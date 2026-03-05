# app/api/endpoints.py
"""
FastAPI route layer for Restaurant Discovery.
"""
from __future__ import annotations

import json
import os
import random
import secrets
from typing import List, cast

import httpx
from dotenv import load_dotenv
from fastapi import APIRouter, Depends, HTTPException, Request, status, Query
from openai import AsyncAzureOpenAI
from sqlalchemy.orm import Session
from sqlalchemy import func
from sqlalchemy.exc import IntegrityError

import app.crud as crud
from app.db.session import get_db
from app.dependencies import get_cache, limiter, set_cache, redis_client
from app.models import Restaurant as DBRestaurant, ShameRestaurant, Comment as DBComment, CommentVote
from app.schemas import RestaurantCreate, RestaurantView, ShameRestaurantView, CommentView

# ─────────────────────────── Config ────────────────────────────────
load_dotenv()

_GOOGLE_KEY = os.environ["GOOGLE_API_KEY"]
_AZURE_OPENAI_DEPLOYMENT = cast(str, os.environ["AZURE_OPENAI_DEPLOYMENT"])
ADMIN_TOKEN = os.environ.get("ADMIN_TOKEN")
if not ADMIN_TOKEN:
    import warnings
    warnings.warn("ADMIN_TOKEN not set - admin features disabled")
    ADMIN_TOKEN = None  # Or generate a random one that's impossible to guess

DEFAULT_OFFICE = "Gbg-office"
OFFICES = {
    "Gbg-office": {
        "lat": 57.705646112118224,
        "lng": 11.967189013099974,
        "address": "Drottninggatan 33, 411 14, Göteborg",
    },
    "Jkpg-office": {
        "lat": 57.780776,
        "lng": 14.163506,
        "address": "Södra Strandgatan 5, 553 20 Jönköping",
    },
    "Sthlm-office": {
        "lat": 59.333543,
        "lng": 18.054212,
        "address": "Torsgatan 4, 111 23 Stockholm",
    },
}

CACHE_TTL = int(os.environ.get("CACHE_TTL", 3600))
GOTHENBURG_RADIUS = int(os.environ.get("GOTHENBURG_RADIUS", 50_000))
MAX_DISTANCE_KM = GOTHENBURG_RADIUS / 1000

router = APIRouter(prefix="/api")
RATE_LIMIT = os.environ.get("RATE_LIMIT", "5/minute")

azure_client = AsyncAzureOpenAI(
    azure_endpoint=os.environ["AZURE_OPENAI_ENDPOINT"],
    api_key=os.environ["AZURE_OPENAI_API_KEY"],
    api_version="2025-01-01-preview",
)

# ─────────────────────────── Helpers ────────────────────────────────
def _is_admin_token_valid(request: Request) -> bool:
    if not ADMIN_TOKEN:
        return False
    admin_token = request.headers.get("X-Admin-Token")
    if not admin_token:
        return False
    return secrets.compare_digest(admin_token, ADMIN_TOKEN)


def _require_admin(request: Request) -> None:
    if not ADMIN_TOKEN:
        raise HTTPException(
            status.HTTP_503_SERVICE_UNAVAILABLE,
            detail="Admin features are disabled on this deployment.",
        )
    if not _is_admin_token_valid(request):
        raise HTTPException(status.HTTP_403_FORBIDDEN, detail="Admin access required.")


async def _google_text_search(query: str, origin_lat: float, origin_lng: float) -> List[dict]:
    url = "https://places.googleapis.com/v1/places:searchText"
    headers = {
        "Content-Type": "application/json",
        "X-Goog-Api-Key": _GOOGLE_KEY,
        "X-Goog-FieldMask": (
            "places.id,places.displayName,places.formattedAddress,"
            "places.location,places.types"
        ),
    }
    body = {
        "textQuery": query,
        "locationBias": {
            "circle": {
                "center": {"latitude": origin_lat, "longitude": origin_lng},
                "radius": float(GOTHENBURG_RADIUS),
            }
        },
        "includedType": "restaurant",
        "rankPreference": "DISTANCE",
    }
    try:
        async with httpx.AsyncClient(timeout=10) as client:
            res = await client.post(url, json=body, headers=headers)
    except httpx.RequestError:
        raise HTTPException(
            status.HTTP_502_BAD_GATEWAY,
            detail="Error searching restaurants via Google Places.",
        )
    if res.status_code != 200:
        try:
            detail = res.json().get("error", "Google Places API error")
        except Exception:
            detail = "Google Places API error"
        raise HTTPException(status.HTTP_502_BAD_GATEWAY, detail=f"Error searching restaurants via Google Places: {detail}")
    return res.json().get("places", [])

async def _drive_distance_km(
    dest_lat: float,
    dest_lng: float,
    origin_lat: float,
    origin_lng: float,
) -> float | None:
    url = "https://maps.googleapis.com/maps/api/distancematrix/json"
    params = {
        "origins": f"{origin_lat},{origin_lng}",
        "destinations": f"{dest_lat},{dest_lng}",
        "mode": "driving",
        "key": _GOOGLE_KEY,
    }
    try:
        async with httpx.AsyncClient(timeout=10) as client:
            res = await client.get(url, params=params)
    except httpx.RequestError:
        return None
    if res.status_code != 200:
        return None
    data = res.json()
    if data.get("status") != "OK" or not data.get("rows"):
        return None
    element = data["rows"][0]["elements"][0]
    if element.get("status") != "OK":
        return None
    return element["distance"]["value"] / 1000

def _normalize_cuisine_label(label: str) -> str:
    cleaned = " ".join(label.strip().split())
    if not cleaned:
        return "Unknown"
    words = []
    for part in cleaned.split():
        token = part.strip(".,;:!?\"'()[]{}")
        if token:
            words.append(token)
    if not words:
        return "Unknown"
    return " ".join(words[:3])


def _canonical_cuisine_key(label: str) -> str:
    normalized_label = _normalize_cuisine_label(label).casefold()
    normalized_label = normalized_label.replace("&", " and ")
    normalized_label = " ".join(normalized_label.split())

    phrase_map = {
        "burger": "burger",
        "burgers": "burger",
        "hamburger": "burger",
        "hamburgers": "burger",
        "sandwich": "sandwich",
        "sandwiches": "sandwich",
        "middle east": "middle eastern",
        "middle eastern": "middle eastern",
        "middle-eastern": "middle eastern",
        "ramen": "ramen",
        "asian street food": "asian street food",
        "street food asian": "asian street food",
        "fish and chips": "fish chips",
        "fish n chips": "fish chips",
        "fish chips": "fish chips",
    }
    if normalized_label in phrase_map:
        return phrase_map[normalized_label]

    synonym_map = {
        "hamburger": "burger",
        "hamburgers": "burger",
        "burgers": "burger",
        "sandwiches": "sandwich",
    }
    tokens = normalized_label.split()
    canonical_tokens: List[str] = []
    for token in tokens:
        mapped = synonym_map.get(token, token)
        if mapped.endswith("ies") and len(mapped) > 3:
            mapped = mapped[:-3] + "y"
        elif mapped.endswith("es") and len(mapped) > 3:
            mapped = mapped[:-2]
        elif mapped.endswith("s") and len(mapped) > 3:
            mapped = mapped[:-1]
        canonical_tokens.append(mapped)
    return " ".join(canonical_tokens[:3])


def _get_existing_cuisines(db: Session, office_name: str | None) -> List[str]:
    def _query_cuisines(for_office: str | None) -> List[str]:
        query = (
            db.query(DBRestaurant.cuisine, func.count(DBRestaurant.id).label("count"))
            .filter(
                DBRestaurant.cuisine.isnot(None),
                DBRestaurant.cuisine != "Unknown",
            )
        )
        if for_office is not None:
            query = query.filter(DBRestaurant.office_name == for_office)
        rows = (
            query.group_by(DBRestaurant.cuisine)
            .order_by(func.count(DBRestaurant.id).desc())
            .limit(40)
            .all()
        )
        return [c for c, _ in rows if c]

    candidates: List[str] = []
    seen: set[str] = set()
    for cuisine in _query_cuisines(office_name):
        key = cuisine.casefold()
        if key not in seen:
            seen.add(key)
            candidates.append(cuisine)
    for cuisine in _query_cuisines(None):
        key = cuisine.casefold()
        if key not in seen:
            seen.add(key)
            candidates.append(cuisine)
    return candidates[:60]


async def _classify_cuisine(name: str, existing_cuisines: List[str] | None = None) -> str:
    existing_cuisines = existing_cuisines or []
    existing_map = {c.casefold(): c for c in existing_cuisines}
    canonical_existing_map = {}
    for cuisine in existing_cuisines:
        canonical_existing_map.setdefault(_canonical_cuisine_key(cuisine), cuisine)

    if existing_cuisines:
        existing_list = "\n".join(f"- {c}" for c in existing_cuisines)
        prompt = (
            "Classify the primary type of food or cuisine served at the restaurant.\n"
            "Prefer reusing an existing category when it reasonably fits.\n\n"
            "Existing categories:\n"
            f"{existing_list}\n\n"
            "Output rules:\n"
            "1) If an existing category fits, respond with that exact category text.\n"
            "2) Otherwise respond as: NEW: <1-3 words>\n"
            "3) Do not create singular/plural or obvious synonym variants of existing categories.\n"
            "4) No extra text.\n\n"
            "Example: if existing has 'Burgers', return 'Burgers' (not 'Hamburger').\n\n"
            f"Restaurant: {name}"
        )
    else:
        prompt = (
            "Classify the primary type of food or cuisine served at the restaurant based on its name. "
            "Be as specific as possible, e.g., 'Pizza' for a pizza place instead of 'Italian', "
            "'Burger' for a burger place instead of 'Fast Food'. "
            "Respond with 1-3 words only, no quotes.\n\n"
            f"Restaurant: {name}"
        )

    try:
        resp = await azure_client.chat.completions.create(
            model=_AZURE_OPENAI_DEPLOYMENT,
            messages=[{"role": "user", "content": prompt}],
        )
        raw = (resp.choices[0].message.content or "").strip()
        if not raw:
            return "Unknown"

        # Prefer exact reuse from existing categories.
        if existing_map:
            cleaned_raw = raw.strip().strip("\"'").strip().lstrip("-* ").strip()
            normalized_raw = _normalize_cuisine_label(cleaned_raw)
            if normalized_raw.casefold() in existing_map:
                return existing_map[normalized_raw.casefold()]
            canonical_raw = _canonical_cuisine_key(normalized_raw)
            if canonical_raw in canonical_existing_map:
                return canonical_existing_map[canonical_raw]
            if cleaned_raw.lower().startswith("new:"):
                candidate = cleaned_raw.split(":", 1)[1]
            else:
                candidate = cleaned_raw
            normalized = _normalize_cuisine_label(candidate)
            if normalized.casefold() in existing_map:
                return existing_map[normalized.casefold()]
            canonical_candidate = _canonical_cuisine_key(normalized)
            if canonical_candidate in canonical_existing_map:
                return canonical_existing_map[canonical_candidate]
            return normalized

        return _normalize_cuisine_label(raw)
    except Exception:
        return "Unknown"

# ─────────────────────────── Routes ────────────────────────────────
@router.get("/offices")
def get_offices():
    return [{"name": k, **v} for k, v in OFFICES.items()]

@router.get("/search-restaurants")
@limiter.limit(RATE_LIMIT)
async def search_restaurants(
    request: Request,
    query: str = Query(..., min_length=2),
    user_lat: float | None = Query(None),
    user_lng: float | None = Query(None),
    db: Session = Depends(get_db),
) -> List[dict]:
    origin_lat = user_lat if user_lat is not None else OFFICES[DEFAULT_OFFICE]["lat"]
    origin_lng = user_lng if user_lng is not None else OFFICES[DEFAULT_OFFICE]["lng"]

    places = await _google_text_search(query, origin_lat, origin_lng)

    results, place_candidates = [], []
    for p in places[:5]:
        pid = p.get("id")
        if not pid or "restaurant" not in p.get("types", []):
            continue
        if crud.get_restaurant_by_google_id(db, pid):
            continue
        if crud.get_shame_by_google_id(db, pid):
            continue
        lat, lng = p["location"]["latitude"], p["location"]["longitude"]
        place_candidates.append(
            {
                "google_id": pid,
                "name": p["displayName"]["text"],
                "address": p.get("formattedAddress"),
                "lat": lat,
                "lng": lng,
            }
        )

    for place in place_candidates:
        km = await _drive_distance_km(
            place["lat"],
            place["lng"],
            origin_lat,
            origin_lng,
        )
        if km is None or km > MAX_DISTANCE_KM:
            continue
        results.append(
            {
                "google_id": place["google_id"],
                "name": place["name"],
                "address": place["address"],
                "distance": km,
            }
        )

    return results


@router.post("/submit-restaurant")
@limiter.limit(RATE_LIMIT)
async def submit_restaurant(
    request: Request, data: dict, db: Session = Depends(get_db)
):
    google_id: str | None = data.get("google_id")
    user_lat: float | None = data.get("user_lat")
    user_lng: float | None = data.get("user_lng")
    office_name: str | None = data.get("office_name")
    if not google_id:
        raise HTTPException(status.HTTP_400_BAD_REQUEST, detail="Please provide a valid Google Place ID.")
    if not office_name:
        raise HTTPException(status.HTTP_400_BAD_REQUEST, detail="Please select an office location.")
    if office_name not in OFFICES:
        raise HTTPException(status.HTTP_400_BAD_REQUEST, detail="Invalid office location.")

    cache_key = f"submit:{google_id}"
    if cached := await get_cache(cache_key):
        return json.loads(cached.decode())

    url = f"https://places.googleapis.com/v1/places/{google_id}"
    headers = {
        "X-Goog-Api-Key": _GOOGLE_KEY,
        "X-Goog-FieldMask": "id,displayName,formattedAddress,location",
    }
    try:
        async with httpx.AsyncClient(timeout=10) as client:
            res = await client.get(url, headers=headers)
    except httpx.RequestError:
        raise HTTPException(
            status.HTTP_502_BAD_GATEWAY,
            detail="Error fetching restaurant details from Google Places.",
        )
    if res.status_code != 200:
        try:
            detail = res.json().get("error", "Google Places API error")
        except Exception:
            detail = "Google Places API error"
        raise HTTPException(status.HTTP_502_BAD_GATEWAY, detail=f"Error fetching restaurant details from Google Places: {detail}")
    place = res.json()

    if crud.get_restaurant_by_google_id(db, google_id):
        raise HTTPException(status.HTTP_409_CONFLICT, detail="This restaurant has already been submitted by another user.")
    if crud.get_shame_by_google_id(db, google_id):
        raise HTTPException(status.HTTP_409_CONFLICT, detail="This restaurant is on the wall of shame.")

    lat = place["location"]["latitude"]
    lng = place["location"]["longitude"]

    origin_lat = user_lat if user_lat is not None else OFFICES[office_name]["lat"]
    origin_lng = user_lng if user_lng is not None else OFFICES[office_name]["lng"]
    km = await _drive_distance_km(lat, lng, origin_lat, origin_lng)
    if km is None:
        raise HTTPException(
            status.HTTP_502_BAD_GATEWAY,
            detail="Could not calculate driving distance for this restaurant.",
        )
    if km > MAX_DISTANCE_KM:
        raise HTTPException(status.HTTP_400_BAD_REQUEST, detail=f"The selected restaurant is too far from the office (more than {MAX_DISTANCE_KM} km).")

    existing_cuisines = _get_existing_cuisines(db, office_name)
    rest = RestaurantCreate(
        google_id=google_id,
        name=place["displayName"]["text"],
        address=place.get("formattedAddress"),
        lat=lat,
        lng=lng,
        distance_from_office=km,
        cuisine=await _classify_cuisine(place["displayName"]["text"], existing_cuisines),
        raw_input="",
        google_data=json.dumps(place),
        office_name=office_name,
    )
    created = crud.create_restaurant(db, rest)
    crud.update_votes(db, created, up=True)

    response = {"message": "Submitted with initial vote", "success": True}
    await set_cache(cache_key, json.dumps(response), CACHE_TTL)
    return response


@router.post("/random-restaurant")
@limiter.limit(RATE_LIMIT)
async def random_restaurant(
    request: Request, data: dict, db: Session = Depends(get_db)
):
    min_km: float | None = data.get("min_distance_km")
    max_km: float | None = data.get("max_distance_km")
    user_location = data.get("userLocation")
    user_lat = user_location.get("lat") if user_location else None
    user_lng = user_location.get("lng") if user_location else None
    office_name: str | None = data.get("office_name")

    query = db.query(DBRestaurant).filter_by(promoted=True)
    if office_name:
        query = query.filter(DBRestaurant.office_name == office_name)
    promoted = query.all()
    if not promoted:
        raise HTTPException(status.HTTP_404_NOT_FOUND, detail="No promoted restaurants available yet.")

    def filter_by_distance(km: float) -> bool:
        """Returns True if the distance is within the specified range."""
        if km > MAX_DISTANCE_KM:
            return False
        if min_km is not None and km < min_km:
            return False
        if max_km is not None and km > max_km:
            return False
        return True

    if user_lat is not None and user_lng is not None:
        candidates = []
        for r in promoted:
            km = await _drive_distance_km(r.lat, r.lng, user_lat, user_lng)
            if km is not None and filter_by_distance(km):
                candidates.append((r, km))
        if not candidates:
            raise HTTPException(status.HTTP_404_NOT_FOUND, detail="No promoted restaurants within the specified range.")
        chosen, distance = random.choice(candidates)
        return {
            "name": chosen.name,
            "type": chosen.cuisine,
            "distance": distance,
            "address": chosen.address,
        }
    elif office_name and office_name in OFFICES:
        origin_lat = OFFICES[office_name]["lat"]
        origin_lng = OFFICES[office_name]["lng"]
        candidates = []
        for r in promoted:
            km = await _drive_distance_km(r.lat, r.lng, origin_lat, origin_lng)
            if km is not None and filter_by_distance(km):
                candidates.append((r, km))
        if not candidates:
            raise HTTPException(status.HTTP_404_NOT_FOUND, detail="No promoted restaurants within the specified range.")
        chosen, distance = random.choice(candidates)
        return {
            "name": chosen.name,
            "type": chosen.cuisine,
            "distance": distance,
            "address": chosen.address,
        }
    else:
        candidates = []
        for r in promoted:
            km = r.distance_from_office
            if filter_by_distance(km):
                candidates.append((r, km))
        if not candidates:
            raise HTTPException(status.HTTP_404_NOT_FOUND, detail="No promoted restaurants within the specified range.")
        chosen, distance = random.choice(candidates)
        return {
            "name": chosen.name,
            "type": chosen.cuisine,
            "distance": distance,
            "address": chosen.address,
        }


@router.post("/vote-restaurant/{id}")
@limiter.limit(RATE_LIMIT)
async def vote_restaurant(
    request: Request, id: int, data: dict = {}, db: Session = Depends(get_db)
):
    up = data.get("up", True)
    restaurant = db.query(DBRestaurant).filter_by(id=id).first()
    if not restaurant:
        raise HTTPException(status.HTTP_404_NOT_FOUND, detail="Restaurant not found.")

    client_id = request.headers.get("X-Client-ID")
    if _is_admin_token_valid(request):
        updated = crud.update_votes(db, restaurant, up=up)
        if updated is None:
            await redis_client.delete(f"submit:{restaurant.google_id}")
            return {"message": "Restaurant removed due to down-votes", "success": True}
        return {"message": "Admin vote recorded", "success": True}

    if not client_id:
        raise HTTPException(status.HTTP_400_BAD_REQUEST, detail="X-Client-ID header is required for voting.")

    locked_restaurant = (
        db.query(DBRestaurant)
        .filter(DBRestaurant.id == restaurant.id)
        .with_for_update()
        .first()
    )
    if not locked_restaurant:
        raise HTTPException(status.HTTP_404_NOT_FOUND, detail="Restaurant not found.")
    if crud.has_voted(db, locked_restaurant.id, client_id):
        raise HTTPException(status.HTTP_409_CONFLICT, detail="You have already voted on this restaurant.")

    try:
        crud.register_vote(db, locked_restaurant.id, client_id, commit=False)
        updated = crud.update_votes(db, locked_restaurant, up=up)
    except IntegrityError:
        db.rollback()
        raise HTTPException(status.HTTP_409_CONFLICT, detail="You have already voted on this restaurant.")
    if updated is None:
        await redis_client.delete(f"submit:{locked_restaurant.google_id}")
        return {"message": "Voted and restaurant removed", "success": True}
    return {"message": "Voted", "success": True}


# ───────────────────── Suggestions & Analytics ─────────────────────
@router.get("/suggestions")
async def get_suggestions(
    db: Session = Depends(get_db),
    user_lat: float | None = Query(None),
    user_lng: float | None = Query(None),
    office_name: str | None = Query(None),
) -> List[RestaurantView]:
    query = db.query(DBRestaurant).filter(DBRestaurant.promoted == False)
    if office_name:
        query = query.filter(DBRestaurant.office_name == office_name)
    rows = query.all()

    if user_lat is not None and user_lng is not None:
        rows_with_km = []
        for r in rows:
            km = await _drive_distance_km(r.lat, r.lng, user_lat, user_lng)
            if km is None or km > MAX_DISTANCE_KM:
                continue
            r.distance_from_office = km  # mutate for response
            rows_with_km.append(r)
        rows = sorted(rows_with_km, key=lambda r: r.distance_from_office)
    elif office_name and office_name in OFFICES:
        origin_lat = OFFICES[office_name]["lat"]
        origin_lng = OFFICES[office_name]["lng"]
        rows_with_km = []
        for r in rows:
            km = await _drive_distance_km(r.lat, r.lng, origin_lat, origin_lng)
            if km is None or km > MAX_DISTANCE_KM:
                continue
            r.distance_from_office = km
            rows_with_km.append(r)
        rows = sorted(rows_with_km, key=lambda r: r.distance_from_office)
    else:
        rows = [r for r in rows if r.distance_from_office <= MAX_DISTANCE_KM]
        rows = sorted(rows, key=lambda r: r.distance_from_office)

    return [RestaurantView.model_validate(r, from_attributes=True) for r in rows]


@router.get("/top-cuisines")
@limiter.limit(RATE_LIMIT)
async def get_top_cuisines(
    request: Request, db: Session = Depends(get_db), office_name: str | None = Query(None)
) -> List[dict]:
    _ = request
    query = db.query(DBRestaurant.cuisine, func.count(DBRestaurant.cuisine).label("count")) \
        .filter(DBRestaurant.cuisine != "Unknown", DBRestaurant.cuisine.isnot(None))
    if office_name:
        query = query.filter(DBRestaurant.office_name == office_name)
    rows = query.group_by(DBRestaurant.cuisine) \
        .order_by(func.count(DBRestaurant.cuisine).desc()) \
        .limit(3) \
        .all()
    return [{"cuisine": c, "count": n} for c, n in rows]


@router.get("/cuisine-tags")
# @limiter.limit(RATE_LIMIT)
async def get_cuisine_tags(
    request: Request, db: Session = Depends(get_db), office_name: str | None = Query(None)
) -> List[dict]:
    _ = request
    query = db.query(DBRestaurant.cuisine, func.count(DBRestaurant.cuisine))
    query = query.filter(
        DBRestaurant.cuisine.isnot(None),
        DBRestaurant.cuisine != "Unknown",
        DBRestaurant.promoted == True
    )
    if office_name:
        query = query.filter(DBRestaurant.office_name == office_name)
    rows = query.group_by(DBRestaurant.cuisine) \
        .order_by(func.count(DBRestaurant.cuisine).desc()) \
        .all()
    return [{"cuisine": c, "count": n} for c, n in rows]


@router.get("/wall-of-shame")
def get_wall_of_shame(db: Session = Depends(get_db), office_name: str | None = Query(None)) -> List[ShameRestaurantView]:
    query = db.query(ShameRestaurant)
    if office_name:
        query = query.filter(ShameRestaurant.office_name == office_name)
    rows = query.order_by(ShameRestaurant.down_votes.desc()).all()
    return [ShameRestaurantView.model_validate(r, from_attributes=True) for r in rows]


@router.get("/restaurant-counts")
def get_restaurant_counts(db: Session = Depends(get_db)) -> List[dict]:
    rows = (
        db.query(DBRestaurant.office_name, func.count(DBRestaurant.id).label("count"))
        .filter(DBRestaurant.promoted == True)
        .group_by(DBRestaurant.office_name)
        .all()
    )
    return [{"office": office, "count": count} for office, count in rows]


@router.delete("/shame-restaurant/{id}")
async def delete_shame_restaurant(
    request: Request, id: int, db: Session = Depends(get_db)
):
    _require_admin(request)

    shame_restaurant = db.query(ShameRestaurant).filter_by(id=id).first()
    if not shame_restaurant:
        raise HTTPException(status.HTTP_404_NOT_FOUND, detail="Shame restaurant not found.")

    name = shame_restaurant.name
    if shame_restaurant.google_id:
        cache_key = f"submit:{shame_restaurant.google_id}"
        await redis_client.delete(cache_key)
    crud.delete_shame_restaurant(db, id)
    return {"message": f"{name} removed from wall of shame", "success": True}

# ───────────────────── Restaurant Details & Comments ─────────────────────
@router.get("/restaurants/by-cuisine")
async def get_restaurants_by_cuisine(
    request: Request,
    cuisine: str = Query(...),
    office_name: str | None = Query(None),
    db: Session = Depends(get_db),
) -> List[RestaurantView]:
    query = db.query(DBRestaurant).filter(
        DBRestaurant.cuisine == cuisine,
        DBRestaurant.promoted == True
    )
    if office_name:
        query = query.filter(DBRestaurant.office_name == office_name)
    restaurants = query.order_by(DBRestaurant.name).all()
    return [RestaurantView.model_validate(r, from_attributes=True) for r in restaurants]


@router.get("/restaurant/{id}/comments")
async def get_restaurant_comments(
    request: Request,
    id: int,
    db: Session = Depends(get_db),
) -> List[CommentView]:
    comments = db.query(DBComment).filter(DBComment.restaurant_id == id).order_by(DBComment.created_at.desc()).all()
    return [CommentView.model_validate(c, from_attributes=True) for c in comments]


@router.post("/restaurant/{id}/comments")
@limiter.limit(RATE_LIMIT)
async def add_restaurant_comment(
    request: Request,
    id: int,
    data: dict,
    db: Session = Depends(get_db),
):
    restaurant = db.query(DBRestaurant).filter_by(id=id).first()
    if not restaurant:
        raise HTTPException(status.HTTP_404_NOT_FOUND, detail="Restaurant not found.")
    
    author_name = data.get("author_name", "").strip()
    text = data.get("text", "").strip()
    
    if not author_name or not text:
        raise HTTPException(status.HTTP_400_BAD_REQUEST, detail="Author name and comment text are required.")
    
    if len(text) > 500:
        raise HTTPException(status.HTTP_400_BAD_REQUEST, detail="Comment too long (max 500 characters).")
    
    comment = DBComment(
        restaurant_id=id,
        author_name=author_name[:50],
        text=text,
    )
    db.add(comment)
    db.commit()
    db.refresh(comment)
    return {"message": "Comment added", "success": True, "id": comment.id}


@router.post("/comment/{id}/vote")
@limiter.limit(RATE_LIMIT)
async def vote_comment(
    request: Request,
    id: int,
    data: dict,
    db: Session = Depends(get_db),
):
    client_uuid = request.headers.get("X-Client-ID")
    if not client_uuid:
        raise HTTPException(status.HTTP_400_BAD_REQUEST, detail="Client ID required.")

    comment = (
        db.query(DBComment)
        .filter(DBComment.id == id)
        .with_for_update()
        .first()
    )
    if not comment:
        raise HTTPException(status.HTTP_404_NOT_FOUND, detail="Comment not found.")

    existing_vote = (
        db.query(CommentVote)
        .filter_by(comment_id=id, client_uuid=client_uuid)
        .first()
    )
    if existing_vote:
        raise HTTPException(status.HTTP_409_CONFLICT, detail="Already voted on this comment.")
    
    up = data.get("up", True)
    if up:
        comment.up_votes += 1
    else:
        comment.down_votes += 1
    
    vote = CommentVote(comment_id=id, client_uuid=client_uuid)
    db.add(vote)
    try:
        db.commit()
    except IntegrityError:
        db.rollback()
        raise HTTPException(status.HTTP_409_CONFLICT, detail="Already voted on this comment.")
    
    return {"message": "Vote recorded", "success": True, "up_votes": comment.up_votes, "down_votes": comment.down_votes}

# ───────────────────── Admin Endpoints ─────────────────────
@router.get("/admin/restaurants")
async def admin_get_restaurants(
    request: Request,
    db: Session = Depends(get_db),
    office_name: str | None = Query(None),
    promoted: bool | None = Query(None),
):
    _require_admin(request)

    query = db.query(DBRestaurant)
    if office_name:
        query = query.filter(DBRestaurant.office_name == office_name)
    if promoted is not None:
        query = query.filter(DBRestaurant.promoted == promoted)
    
    restaurants = query.order_by(DBRestaurant.created_at.desc()).all()
    return [RestaurantView.model_validate(r, from_attributes=True) for r in restaurants]


@router.patch("/admin/restaurant/{id}")
async def admin_update_restaurant(
    request: Request,
    id: int,
    data: dict,
    db: Session = Depends(get_db),
):
    _require_admin(request)

    restaurant = db.query(DBRestaurant).filter_by(id=id).first()
    if not restaurant:
        raise HTTPException(status.HTTP_404_NOT_FOUND, detail="Restaurant not found.")

    if "cuisine" in data:
        restaurant.cuisine = data["cuisine"]
    if "promoted" in data:
        restaurant.promoted = data["promoted"]
    if "name" in data:
        restaurant.name = data["name"]
    if "office_name" in data:
        restaurant.office_name = data["office_name"]

    db.commit()
    db.refresh(restaurant)
    return {"message": "Updated successfully", "success": True}


@router.delete("/admin/restaurant/{id}")
async def admin_delete_restaurant(
    request: Request,
    id: int,
    db: Session = Depends(get_db),
):
    _require_admin(request)

    restaurant = db.query(DBRestaurant).filter_by(id=id).first()
    if not restaurant:
        raise HTTPException(status.HTTP_404_NOT_FOUND, detail="Restaurant not found.")

    await redis_client.delete(f"submit:{restaurant.google_id}")
    
    db.delete(restaurant)
    db.commit()
    return {"message": "Deleted successfully", "success": True}

@router.delete("/admin/comment/{id}")
async def admin_delete_comment(
    request: Request,
    id: int,
    db: Session = Depends(get_db),
):
    _require_admin(request)

    comment = db.query(DBComment).filter_by(id=id).first()
    if not comment:
        raise HTTPException(status.HTTP_404_NOT_FOUND, detail="Comment not found.")

    db.delete(comment)
    db.commit()
    return {"message": "Comment deleted", "success": True}
