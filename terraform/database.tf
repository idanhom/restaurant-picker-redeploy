resource "azurerm_postgresql_flexible_server" "main" {
  location            = "swedencentral"
  name                = "restaurant-picker-pg"
  resource_group_name = "rg-restaurant-picker"
  zone                = "1"
  depends_on = [
    azurerm_resource_group.main
  ]
}

resource "azurerm_postgresql_flexible_server_database" "main" {
  name      = "appdb"
  server_id = azurerm_postgresql_flexible_server.main.id
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "main" {
  end_ip_address   = "0.0.0.0"
  name             = "AllowAllAzureServicesAndResourcesWithinAzureIps_2025-12-29_7-22-46"
  server_id        = azurerm_postgresql_flexible_server.main.id
  start_ip_address = "0.0.0.0"
}
