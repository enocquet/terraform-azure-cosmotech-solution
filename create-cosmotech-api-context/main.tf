# Create 1 organization -> 1 solution -> 1 workspace

resource "restapi_object" "create_organization" {
  data = "{ \"name\": \"${var.organization_name}\", \"security\": { \"default\": \"reader\", \"accessControlList\": ${jsonencode(var.acl)} } }"
  # data = templatefile("${path.module}/templates/organization.json", {
  #   organization_name = var.organization_name,
  #   acl               = jsonencode(var.acl),
  # })
  path = "/organizations"
}

resource "time_sleep" "wait_15_seconds_after_organization" {
  depends_on = [restapi_object.create_organization]

  create_duration = "15s"
}

resource "restapi_object" "create_solution" {
  data = file("${path.module}/templates/solution.json")
  path = "/organizations/${restapi_object.create_organization.api_data.id}/solutions"

  depends_on = [time_sleep.wait_15_seconds_after_organization]
}

resource "time_sleep" "wait_15_seconds_after_solution" {
  depends_on = [restapi_object.create_solution]

  create_duration = "15s"
}

resource "restapi_object" "create_workspace" {
  data = templatefile("${path.module}/templates/workspace.json", {
    solution_id    = restapi_object.create_solution.api_data.id,
    workspace_name = var.workspace_name,
    acl            = var.acl,
  })
  path = "/organizations/${restapi_object.create_organization.api_data.id}/workspaces"

  depends_on = [time_sleep.wait_15_seconds_after_solution]
}

# Then 1 connector -> 1 dataset
resource "time_sleep" "wait_15_seconds_after_workspace" {
  depends_on = [restapi_object.create_workspace]

  create_duration = "15s"
}

resource "restapi_object" "create_connector" {
  data = file("${path.module}/templates/connector.json")
  path = "/connectors"

  depends_on = [time_sleep.wait_15_seconds_after_workspace]
}

resource "time_sleep" "wait_15_seconds_after_connector" {
  depends_on = [restapi_object.create_connector]

  create_duration = "15s"
}

resource "restapi_object" "create_dataset" {
  data = templatefile("${path.module}/templates/dataset.json", {
    connector_id    = restapi_object.create_connector.api_data.id,
    organization_id = restapi_object.create_organization.api_data.id,
  })
  path = "/organizations/${restapi_object.create_organization.api_data.id}/datasets"

  depends_on = [time_sleep.wait_15_seconds_after_connector]
}

# Create Scenario
# resource "restapi_object" "create_scenario" {
#   data = templatefile("${path.module}/templates/scenario.json", {
#     organization_id = restapi_object.create_organization.api_data.id,
#     solution_id = restapi_object.create_solution.api_data.id,
#   })
#   path = "/organizations/${restapi_object.create_organization.api_data.id}/workspaces/${restapi_object.create_workspace.api_data.id}/scenarios"

#   depends_on = [ time_sleep.wait_15_seconds_after_connector ]
# }

# Next scenarioRun ?