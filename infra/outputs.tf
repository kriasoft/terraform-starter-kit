# Output Values
# https://www.terraform.io/language/values/outputs

output "workspace" {
  value = terraform.workspace
}

output "project_id" {
  value = data.google_project.default.id
}

output "project_number" {
  value = data.google_project.default.number
}
