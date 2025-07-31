from fastapi import Request
from slowapi import Limiter
from slowapi.util import get_remote_address
from dotenv import load_dotenv
import os
from redis.asyncio import Redis
load_dotenv()

limiter = Limiter(key_func=get_remote_address)
redis_client = Redis(host=os.getenv("REDIS_HOST", "localhost"), port=6379, db=0)

async def get_cache(key: str) -> bytes | None:
    return await redis_client.get(key)

async def set_cache(key: str, value: str, ttl: int):
    await redis_client.setex(key, ttl, value)