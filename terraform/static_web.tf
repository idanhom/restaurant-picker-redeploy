resource "azurerm_static_web_app" "main" {
  location            = "westeurope"
  name                = "restaurant-picker-web"
  # repository_branch   = "main"
  # repository_url      = "https://github.com/idanhom/restaurant-picker-redeploy"
  resource_group_name = "rg-restaurant-picker"
  depends_on = [
    azurerm_resource_group.main
  ]
  lifecycle {
    ignore_changes = [ repository_branch, repository_url ]
  }
}
