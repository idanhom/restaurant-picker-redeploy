import os
from redis.asyncio import Redis

redis_host = os.getenv('AZURE_REDIS_HOST', 'redis')
redis_port = int(os.getenv('AZURE_REDIS_PORT', 6379))
redis_pass = os.getenv('AZURE_REDIS_PASSWORD')  # Required in Azure

# Use SSL for Azure Redis (port 6380)
if 'windows.net' in redis_host:  # Detect Azure host
    redis_client = Redis(host=redis_host, port=redis_port, password=redis_pass, db=0, ssl=True)
else:
    redis_client = Redis(host=redis_host, port=redis_port, db=0)