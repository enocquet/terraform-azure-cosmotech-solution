resource "random_integer" "this" {
  max = 999999
  min = 100000
}

locals {
  acl = [{
    "id"   = var.owner_sp_name
    "role" = "editor"
    }
  ]
}

module "create-cosmotech-api-context" {
  source = "./create-cosmotech-api-context"

  api_uri             = var.api_uri
  oauth_client_id     = var.oauth_client_id
  oauth_client_secret = var.oauth_client_secret
  oauth_scopes        = var.oauth_scopes
  organization_name   = var.organization_name
  workspace_name      = var.workspace_name
  acl                 = local.acl
}

module "create-webapp" {
  source = "./create-webapp"

  resource_group_name    = var.tenant_resource_group
  repositoryUrl          = var.repositoryUrl
  repositoryBranch       = var.repositoryBranch
  power_bi_tenant_id     = var.power_bi_tenant_id
  power_bi_client_id     = var.power_bi_client_id
  power_bi_client_secret = var.power_bi_client_secret
  power_bi_workspace_id  = var.power_bi_workspace_id
}

resource "azurerm_storage_account" "new-workspace" {
  name                            = "workspace-${random_integer.this.result}"
  resource_group_name             = var.tenant_resource_group
  location                        = var.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  account_kind                    = "StorageV2"
  default_to_oauth_authentication = false
  min_tls_version                 = "TLS1_2"
  shared_access_key_enabled       = true
  enable_https_traffic_only       = true
  access_tier                     = "Hot"
  public_network_access_enabled   = true
  network_rules {
    bypass         = ["AzureServices"]
    default_action = "Allow"
  }
}

resource "azurerm_storage_container" "terraform" {
  name                  = "terraform-${random_integer.this.result}"
  storage_account_name  = azurerm_storage_account.new-workspace.name
  container_access_type = "private"
}

# Only workspace key is needed e.g an arbitrary value. This is not the workspace Id !
module "new-workspace" {
  source  = "enocquet/cosmotech-workspace/azure"
  version = "1.0.0-dev"

  resource_group              = var.tenant_resource_group
  client_id                   = var.client_id
  client_secret               = var.client_secret
  tenant_id                   = var.tenant_id
  subscription_id             = var.subscription_id
  adx_name                    = var.adx_name
  app_adt_name                = var.app_adt_name
  app_platform_name           = var.app_platform_name
  organization_id             = module.create-cosmotech-api-context.organization_id
  workspace_key               = "workspace-${random_integer.this.result}"
  storage_account_name        = azurerm_storage_account.new-workspace.name
  owner_sp_name               = var.owner_sp_name
  aad_groups_and_assignements = true
  adx_identity_uid            = var.adx_identity_uid

  depends_on = [module.create-cosmotech-api-context, azurerm_storage_account.new-workspace]
}