terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.99.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.38.0"
    }
    restapi = {
      source  = "Mastercard/restapi"
      version = "1.18.2"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "1.12.1"
    }
  }

  required_version = ">= 1.3.9"
}

locals {
  oauth_token_endpoint = "https://login.microsoftonline.com/${var.tenant_id}/oauth2/v2.0/token"
}

provider "restapi" {
  uri = var.api_uri
  oauth_client_credentials {
    oauth_client_id      = var.oauth_client_id
    oauth_client_secret  = var.oauth_client_secret
    oauth_token_endpoint = local.oauth_token_endpoint
    oauth_scopes         = var.oauth_scopes
  }
  write_returns_object = true
  debug                = true # TODO: remove in production
  update_method        = "PATCH"
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

provider "azuread" {
  tenant_id     = var.tenant_id
  client_id     = var.client_id
  client_secret = var.client_secret
}

provider "azapi" {
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}