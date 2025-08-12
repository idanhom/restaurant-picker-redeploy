# Vars
RG="restaurant-picker"
LOC="westeurope"
ACR_NAME="restaurantpickeracr1"   # <= lowercase, alphanumeric, 5-50 chars

# Is the name available?
az acr check-name -n "$ACR_NAME" -o table

# Create the registry (if not already created)
az acr create -g "$RG" -n "$ACR_NAME" -l "$LOC" --sku Basic