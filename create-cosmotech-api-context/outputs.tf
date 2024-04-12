output "organization_id" {
  value = restapi_object.create_organization.api_data.id
}

output "solution_id" {
  value = restapi_object.create_solution.api_data.id
}

output "workspace_id" {
  value = restapi_object.create_workspace.api_data.id
}

output "connector_id" {
  value = restapi_object.create_connector.api_data.id
}

output "dataset_id" {
  value = restapi_object.create_dataset.api_data.id
}