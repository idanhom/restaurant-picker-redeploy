resource "azurerm_log_analytics_workspace" "main" {
  location            = "swedencentral"
  name                = "workspace-rgrestaurantpickerjfAk"
  resource_group_name = "rg-restaurant-picker"
  depends_on = [
    azurerm_resource_group.main
  ]
}
