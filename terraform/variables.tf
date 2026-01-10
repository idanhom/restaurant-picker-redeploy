# =============================================================================
# Project Settings
# =============================================================================
variable "project_name" {
  description = "Project name used in resource naming"
  type        = string
  default     = "restaurant-picker"
}

variable "location" {
  description = "Azure region for most resources"
  type        = string
  default     = "swedencentral"
}

variable "static_web_location" {
  description = "Azure region for Static Web App (limited regions available)"
  type        = string
  default     = "westeurope"
}

variable "container_image_tag" {
  description = "Initial container image tag (CI/CD manages updates)"
  type        = string
  default     = "5549584bfb16da0fc436dc2378d0de27be4bcc3a"
}

# =============================================================================
# Secrets
# =============================================================================
variable "acr_password" {
    description = "Azure Container Registry Password"
    type = string
    sensitive = true
}

variable "database_url" {
    description = "PostgreSQL connection string"
    type = string
    sensitive = true
}

variable "redis_url" {
    description = "Redis connection string"
    type = string
    sensitive = true
  
}

variable "google_api_key" {
    description = "Google API key"
    type = string
    sensitive = true
}

variable "azure_openai_api_key" {
    description = "Azure OpenAI API key"
    type = string
    sensitive = true
}

variable "azure_openai_endpoint" {
    description = "Azure OpenAI endpoint"
    type = string
    sensitive = true
}

variable "admin_token" {
    description = "Admin authentication token"
    type = string
    sensitive = true
}

variable "cors_origin" {
    description = "Allowed CORS origin"
    type = string
    sensitive = true
  
}