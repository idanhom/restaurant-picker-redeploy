resource "azurerm_resource_group" "res-0" {
  location = "swedencentral"
  name     = "rg-restaurant-picker"
}
resource "azurerm_container_app" "res-1" {
  container_app_environment_id = azurerm_container_app_environment.res-2.id
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
      image  = "restaurantpickeracr.azurecr.io/restaurantpicker:5549584bfb16da0fc436dc2378d0de27be4bcc3a"
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
}
resource "azurerm_container_app_environment" "res-2" {
  location                   = "swedencentral"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-576.id
  name                       = "restaurant-picker-env"
  resource_group_name        = "rg-restaurant-picker"
}
resource "azurerm_redis_cache" "res-3" {
  capacity            = 0
  family              = "C"
  location            = "swedencentral"
  name                = "restaurant-picker-redis"
  redis_version       = "6.0"
  resource_group_name = "rg-restaurant-picker"
  sku_name            = "Basic"
  depends_on = [
    azurerm_resource_group.res-0
  ]
}


resource "azurerm_postgresql_flexible_server_database" "res-570" {
  name      = "appdb"
  server_id = azurerm_postgresql_flexible_server.res-13.id
}


resource "azurerm_container_registry" "res-7" {
  admin_enabled       = true
  location            = "swedencentral"
  name                = "restaurantpickeracr"
  resource_group_name = "rg-restaurant-picker"
  sku                 = "Basic"
  depends_on = [
    azurerm_resource_group.res-0
  ]
}

resource "azurerm_postgresql_flexible_server" "res-13" {
  location            = "swedencentral"
  name                = "restaurant-picker-pg"
  resource_group_name = "rg-restaurant-picker"
  zone                = "1"
  depends_on = [
    azurerm_resource_group.res-0
  ]
}

resource "azurerm_static_web_app" "res-1247" {
  location            = "westeurope"
  name                = "restaurant-picker-web"
  repository_branch   = "main"
  repository_url      = "https://github.com/idanhom/restaurant-picker-redeploy"
  resource_group_name = "rg-restaurant-picker"
  depends_on = [
    azurerm_resource_group.res-0
  ]
}

resource "azurerm_log_analytics_workspace" "res-576" {
  location            = "swedencentral"
  name                = "workspace-rgrestaurantpickerjfAk"
  resource_group_name = "rg-restaurant-picker"
  depends_on = [
    azurerm_resource_group.res-0
  ]
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "res-575" {
  end_ip_address   = "0.0.0.0"
  name             = "AllowAllAzureServicesAndResourcesWithinAzureIps_2025-12-29_7-22-46"
  server_id        = azurerm_postgresql_flexible_server.res-13.id
  start_ip_address = "0.0.0.0"
}
