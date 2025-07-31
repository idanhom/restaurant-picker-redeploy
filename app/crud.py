# app/crud.py
from sqlalchemy.orm import Session
from sqlalchemy import case
from app.models import Restaurant, Vote, ShameRestaurant
from app.schemas import RestaurantCreate
from datetime import datetime


# ───────────────────────────── Vote helpers ────────────────────────────────
def has_voted(db: Session, restaurant_id: int, client_uuid: str) -> bool:
    return (
        db.query(Vote)
        .filter(Vote.restaurant_id == restaurant_id, Vote.client_uuid == client_uuid)
        .first()
        is not None
    )


def register_vote(db: Session, restaurant_id: int, client_uuid: str):
    db.add(Vote(restaurant_id=restaurant_id, client_uuid=client_uuid))
    db.commit()


# ─────────────────────── Restaurant CRUD (unchanged) ───────────────────────
def get_restaurant_by_google_id(db: Session, google_id: str):
    return db.query(Restaurant).filter(Restaurant.google_id == google_id).first()

def get_shame_by_google_id(db: Session, google_id: str):
    return db.query(ShameRestaurant).filter(ShameRestaurant.google_id == google_id).first()


def create_restaurant(db: Session, restaurant: RestaurantCreate):
    db_restaurant = Restaurant(
        google_id=restaurant.google_id,
        name=restaurant.name,
        address=restaurant.address,
        lat=restaurant.lat,
        lng=restaurant.lng,
        distance_from_office=restaurant.distance_from_office,
        cuisine=restaurant.cuisine,
        raw_input=restaurant.raw_input,
        google_data=restaurant.google_data,
        created_at=datetime.utcnow(),
        office_name=restaurant.office_name,
    )
    db.add(db_restaurant)
    db.commit()
    db.refresh(db_restaurant)
    return db_restaurant


def update_votes(db: Session, restaurant: Restaurant, up: bool):
    vote_col = Restaurant.up_votes if up else Restaurant.down_votes
    incr_expr = vote_col + 1
    promoted_expr = (
        Restaurant.up_votes
        + (1 if up else 0)
        - Restaurant.down_votes
        - (0 if up else 1)
        >= 3
    )
    promoted_update = case((promoted_expr, True), else_=Restaurant.promoted)

    db.query(Restaurant).filter(Restaurant.id == restaurant.id).update(
        {vote_col: incr_expr, Restaurant.promoted: promoted_update}
    )
    db.commit()
    db.refresh(restaurant)

    if not up and restaurant.down_votes >= 3:  # Adjust to >3 if strict
        # Move to shame
        shame = ShameRestaurant(
            google_id=restaurant.google_id,
            name=restaurant.name,
            address=restaurant.address,
            down_votes=restaurant.down_votes,
            created_at=restaurant.created_at,
            office_name=restaurant.office_name,
        )
        db.add(shame)
        db.delete(restaurant)
        db.commit()
        return None

    return restaurant


def get_suggestions(db: Session):
    return (
        db.query(Restaurant)
        .filter(Restaurant.promoted == False)  # noqa: E712
        .order_by(Restaurant.distance_from_office.asc())
        .all()
    )

def delete_shame_restaurant(db: Session, id: int):
    shame_restaurant = db.query(ShameRestaurant).filter_by(id=id).first()
    if shame_restaurant:
        db.delete(shame_restaurant)
        db.commit()

def get_shamed_restaurants(db: Session):
    return db.query(ShameRestaurant).order_by(ShameRestaurant.down_votes.desc()).all()