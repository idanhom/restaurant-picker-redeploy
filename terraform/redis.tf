resource "azurerm_redis_cache" "main" {
  capacity            = 0
  family              = "C"
  location            = "swedencentral"
  name                = "restaurant-picker-redis"
  redis_version       = "6"
  resource_group_name = "rg-restaurant-picker"
  sku_name            = "Basic"
  depends_on = [
    azurerm_resource_group.main
  ]
}
