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