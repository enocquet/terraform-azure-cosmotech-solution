variable "tenant_id" {
  description = "The tenant id"
}

variable "subscription_id" {
  description = "The subscription id"
}

variable "client_id" {
  description = "The client id"
  default     = ""
}

variable "client_secret" {
  description = "The client secret"
  default     = ""
}

variable "tenant_resource_group" {
  type = string
}

variable "platform_resource_group" {
  type = string
}

variable "location" {
  type    = string
  default = "West Europe"
}

variable "app_platform_name" {
  type = string
}

variable "adx_name" {
  type = string
}

variable "app_adt_name" {
  type = string
}

variable "organization_name" {
  type = string
}

variable "api_uri" {
  type = string
}

variable "oauth_client_id" {
  type = string
}

variable "oauth_client_secret" {
  type = string
}

variable "oauth_scopes" {
  type = list(string)
}

variable "acl" {
  type = list(map(string))
  default = [{
    "id"   = "john.doe@cosmotech.com"
    "role" = "viewer"
  }]
}

variable "workspace_name" {
  type = string
}

variable "repositoryUrl" {
  type = string
}

variable "repositoryBranch" {
  type = string
}

variable "power_bi_authority_uri" {
  type    = string
  default = "https://login.microsoftonline.com/common/v2.0"
}

variable "power_bi_scope" {
  type    = string
  default = "https://analysis.windows.net/powerbi/api/.default"
}

variable "power_bi_tenant_id" {
  type = string
}

variable "power_bi_client_id" {
  type = string
}

variable "power_bi_client_secret" {
  type = string
}

variable "power_bi_workspace_id" {
  type = string
}

variable "adx_identity_uid" {
  type = string
}

variable "owner_sp_name" {
  type = string
}