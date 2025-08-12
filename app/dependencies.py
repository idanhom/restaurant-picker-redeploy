# app/dependencies.py
from fastapi import Request
from slowapi import Limiter
from slowapi.util import get_remote_address
from dotenv import load_dotenv
from redis.asyncio import Redis, from_url as redis_from_url
import os

load_dotenv()

limiter = Limiter(key_func=get_remote_address)

# Prefer a single REDIS_URL; fall back to individual pieces.
# Works locally (no TLS) and on Azure Cache for Redis (TLS on 6380).
_redis_url = os.getenv("REDIS_URL")
if _redis_url:
    redis_client = redis_from_url(_redis_url, encoding=None, decode_responses=False)
else:
    redis_client = Redis(
        host=os.getenv("REDIS_HOST", "localhost"),
        port=int(os.getenv("REDIS_PORT", "6379")),
        db=int(os.getenv("REDIS_DB", "0")),
        password=os.getenv("REDIS_PASSWORD"),
        ssl=os.getenv("REDIS_SSL", "false").lower() == "true",
    )

async def get_cache(key: str) -> bytes | None:
    try:
        return await redis_client.get(key)
    except Exception:
        return None  # degrade gracefully if Redis is down/unset

async def set_cache(key: str, value: str, ttl: int):
    try:
        await redis_client.setex(key, ttl, value)
    except Exception:
        pass  # best-effort cache
