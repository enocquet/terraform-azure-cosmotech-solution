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

variable "organization_name" {
  type = string
}

variable "workspace_name" {
  type = string
}

variable "acl" {
  type = list(map(string))
  default = [{
    "id"   = "john.doe@cosmotech.com"
    "role" = "viewer"
  }]
}