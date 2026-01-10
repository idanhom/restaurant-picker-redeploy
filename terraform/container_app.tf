resource "azurerm_container_app" "main" {
  container_app_environment_id = azurerm_container_app_environment.main.id
  max_inactive_revisions       = 100
  name                         = "restaurant-picker-api"
  resource_group_name          = "rg-restaurant-picker"
  revision_mode                = "Single"
  workload_profile_name        = "Consumption"
  identity {
    type = "SystemAssigned"
  }
  ingress {
    external_enabled = true
    target_port      = 8000
    traffic_weight {
      percentage      = 100
      revision_suffix = "0000026"
    }
  }
  registry {
    password_secret_name = "restaurantpickeracrazurecrio-restaurantpickeracr"
    server               = "restaurantpickeracr.azurecr.io"
    username             = "restaurantpickeracr"
  }
  secret {
    name  = "restaurantpickeracrazurecrio-restaurantpickeracr"
    value = var.acr_password
  }
  template {
    max_replicas = 2
    min_replicas = 1
    container {
      cpu    = 0.5
      image  = "${azurerm_container_registry.main.login_server}/restaurantpicker:${var.container_image_tag}" #"restaurantpickeracr.azurecr.io/restaurantpicker:5549584bfb16da0fc436dc2378d0de27be4bcc3a"
      memory = "1Gi"
      name   = "restaurant-picker-api"
      env {
        name  = "DATABASE_URL"
        value = var.database_url
      }
      env {
        name  = "REDIS_URL"
        value = var.redis_url
      }
      env {
        name  = "GOOGLE_API_KEY"
        value = var.google_api_key
      }
      env {
        name  = "AZURE_OPENAI_API_KEY"
        value = var.azure_openai_api_key
      }
      env {
        name  = "AZURE_OPENAI_ENDPOINT"
        value = var.azure_openai_endpoint
      }
      env {
        name  = "AZURE_OPENAI_DEPLOYMENT"
        value = "gpt-5-mini"
      }
      env {
        name  = "ADMIN_TOKEN"
        value = var.admin_token
      }
      env {
        name  = "RATE_LIMIT"
        value = "100"
      }
      env {
        name  = "CACHE_TTL"
        value = "3600"
      }
      env {
        name  = "CORS_ORIGINS"
        value = var.cors_origin
      }
    }
  }
  lifecycle {
    ignore_changes = [ template[0].container[0].image ]
  }
}
resource "azurerm_container_app_environment" "main" {
  location                   = "swedencentral"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id
  name                       = "restaurant-picker-env"
  resource_group_name        = "rg-restaurant-picker"
}
