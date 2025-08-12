# ───────────────────────────────────────────────────────────────────
# 0) Variables - EDIT the values for your subscription / names
# ───────────────────────────────────────────────────────────────────
SUB="3e00befb-2b03-4b60-b8a0-faf06ad28b5e"
RG="restaurant-picker"
LOC="westeurope"
ENV_NAME="restaurantpicker-cae"
ACR="restaurantpickeracr1"
CA_NAME="restaurantpicker-ca"

# Optional: create Postgres (Flexible Server)
PG_NAME="rp-postgres"
PG_ADMIN_USER="pgadmin"
PG_ADMIN_PASS="1234"
DB_NAME="appdb"

# Optional: create Azure Cache for Redis (Basic C0)
REDIS_NAME="rp-redis-c0"

# Your SWA origin (e.g. https://polite-beach-12345.z01.azurestaticapps.net)
SWA_ORIGIN="https://red-beach-038148203.1.azurestaticapps.net"

# Azure OpenAI (existing)
AOAI_ENDPOINT="https://oscar-mbja5r5l-eastus2.cognitiveservices.azure.com"
AOAI_DEPLOYMENT="gpt-4.1-nano"

# Google Places
GOOGLE_API_KEY="AIzaSyCsAIiWwbspbqtwK5ws864DQvJPZbWIAdI"

az account set -s "$SUB"
