resource "azurerm_container_registry" "main" {
  admin_enabled       = true
  location            = "swedencentral"
  name                = "restaurantpickeracr"
  resource_group_name = "rg-restaurant-picker"
  sku                 = "Basic"
  depends_on = [
    azurerm_resource_group.main
  ]
}
