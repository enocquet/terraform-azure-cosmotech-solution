resource "random_integer" "this" {
  max = 999999
  min = 100000
}

data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

resource "azurerm_static_web_app" "example" {
  name                               = "webapp-${random_integer.this.result}"
  resource_group_name                = data.azurerm_resource_group.this.name
  location                           = data.azurerm_resource_group.this.location
  configuration_file_changes_enabled = true
  preview_environments_enabled       = true
  sku_size                           = "Standard"
  sku_tier                           = "Standard"

  app_settings = {
    "POWER_BI_AUTHORITY_URI" : var.power_bi_authority_uri,
    "POWER_BI_SCOPE" : var.power_bi_scope,
    "POWER_BI_TENANT_ID" : var.power_bi_tenant_id,
    "POWER_BI_CLIENT_ID" : var.power_bi_client_id,
    "POWER_BI_CLIENT_SECRET" : var.power_bi_client_secret,
    "POWER_BI_WORKSPACE_ID" : var.power_bi_workspace_id
  }
}

resource "azapi_update_resource" "example_app_settings" {
  type        = "Microsoft.Web/staticSites@2022-03-01"
  resource_id = azurerm_static_web_app.example.id
  body = jsonencode({
    properties = {
      repositoryUrl = var.repositoryUrl
      branch        = var.repositoryBranch
    }
  })
}