provider "azurerm" {
  features {
  }
  subscription_id                 = "3e00befb-2b03-4b60-b8a0-faf06ad28b5e"
  environment                     = "public"
  use_msi                         = false
  use_cli                         = true
  use_oidc                        = false
  resource_provider_registrations = "none"
}
