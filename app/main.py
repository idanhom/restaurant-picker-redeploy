# app/main.py
from contextlib import asynccontextmanager
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from app.db.session import Base, engine
from app.api.endpoints import router
from app.dependencies import limiter
from slowapi.errors import RateLimitExceeded
import os

@asynccontextmanager
async def lifespan(app: FastAPI):
    """
    Runs once when the container starts, before the first request.
    Good for one-off tasks such as creating tables or warming caches.
    """
    Base.metadata.create_all(bind=engine, checkfirst=True)  # dev-only
    yield

app = FastAPI(title="Restaurant Discovery API", lifespan=lifespan)
app.include_router(router)
app.state.limiter = limiter

@app.exception_handler(RateLimitExceeded)
async def rate_limit_handler(request, exc):
    return JSONResponse(
        status_code=429,
        content={"detail": "Rate limit exceeded. Please try again in a minute."},
    )

# CORS - configurable by env var
cors_env = os.getenv("CORS_ORIGINS", "http://localhost:3000")
origins = [o.strip() for o in cors_env.split(",") if o.strip()]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["GET", "POST", "DELETE", "PATCH"],
    allow_headers=["Content-Type", "X-Client-ID", "X-Admin-Token"],
)