variable "resource_group_name" {
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