# app/models.py
from sqlalchemy import (
    Column,
    Integer,
    String,
    Float,
    DateTime,
    Boolean,
    ForeignKey,
)
from datetime import datetime
from app.db.session import Base


class Restaurant(Base):
    __tablename__ = "restaurants"
    id = Column(Integer, primary_key=True, index=True)
    google_id = Column(String, unique=True, index=True, nullable=False)
    name = Column(String, nullable=False)
    address = Column(String)
    lat = Column(Float)
    lng = Column(Float)
    distance_from_office = Column(Float)
    cuisine = Column(String)
    raw_input = Column(String)
    google_data = Column(String)  # JSON string
    up_votes = Column(Integer, default=0)
    down_votes = Column(Integer, default=0)
    promoted = Column(Boolean, default=False)
    created_at = Column(DateTime, default=datetime.utcnow)
    office_name = Column(String, nullable=True)


class Vote(Base):
    """
    One row per restaurant-and-client UUID.
    """
    __tablename__ = "votes"
    id = Column(Integer, primary_key=True)
    restaurant_id = Column(Integer, ForeignKey("restaurants.id"), nullable=False)
    client_uuid = Column(String, index=True, nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow)


class ShameRestaurant(Base):
    __tablename__ = "shame_restaurants"
    id = Column(Integer, primary_key=True, index=True)
    google_id = Column(String, nullable=True)
    name = Column(String, nullable=False)
    address = Column(String)
    down_votes = Column(Integer, default=0)
    created_at = Column(DateTime, default=datetime.utcnow)
    office_name = Column(String, nullable=True)


class Comment(Base):
    __tablename__ = "comments"
    id = Column(Integer, primary_key=True)
    restaurant_id = Column(Integer, ForeignKey("restaurants.id"), nullable=False)
    author_name = Column(String, nullable=False)
    text = Column(String, nullable=False)
    up_votes = Column(Integer, default=0)
    down_votes = Column(Integer, default=0)
    created_at = Column(DateTime, default=datetime.utcnow)


class CommentVote(Base):
    __tablename__ = "comment_votes"
    id = Column(Integer, primary_key=True)
    comment_id = Column(Integer, ForeignKey("comments.id"), nullable=False)
    client_uuid = Column(String, index=True, nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow)