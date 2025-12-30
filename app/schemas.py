# app/schemas.py
from datetime import datetime
from typing import Optional

from pydantic import BaseModel, ConfigDict


# ──────────────────────────────────────────────────────────────────────────────
# Shared fields
# ──────────────────────────────────────────────────────────────────────────────
class RestaurantBase(BaseModel):
    name: str
    address: Optional[str] = None
    lat: Optional[float] = None
    lng: Optional[float] = None
    distance_from_office: Optional[float] = None  # km
    cuisine: Optional[str] = None
    office_name: Optional[str] = None


# ──────────────────────────────────────────────────────────────────────────────
# Write‑only model (used when inserting into DB)
# ──────────────────────────────────────────────────────────────────────────────
class RestaurantCreate(RestaurantBase):
    google_id: str
    raw_input: str
    google_data: str


# ──────────────────────────────────────────────────────────────────────────────
# Full DB row (read)
# ──────────────────────────────────────────────────────────────────────────────
class Restaurant(RestaurantBase):
    id: int
    google_id: str
    up_votes: int
    down_votes: int
    promoted: bool
    created_at: datetime

    # IMPORTANT: enable ORM → Pydantic conversion
    model_config = ConfigDict(from_attributes=True)


# ──────────────────────────────────────────────────────────────────────────────
# Lightweight view sent to the frontend
# ──────────────────────────────────────────────────────────────────────────────
class RestaurantView(RestaurantBase):
    id: int
    google_id: str
    up_votes: int
    down_votes: int
    promoted: bool

    model_config = ConfigDict(from_attributes=True)


class ShameRestaurantView(BaseModel):
    id: int
    google_id: Optional[str] = None
    name: str
    address: Optional[str]
    down_votes: int
    office_name: Optional[str] = None

    model_config = ConfigDict(from_attributes=True)


# ──────────────────────────────────────────────────────────────────────────────
# Comments
# ──────────────────────────────────────────────────────────────────────────────
class CommentCreate(BaseModel):
    author_name: str
    text: str


class CommentView(BaseModel):
    id: int
    restaurant_id: int
    author_name: str
    text: str
    created_at: datetime

    model_config = ConfigDict(from_attributes=True)