# Output Values
# https://www.terraform.io/language/values/outputs

output "workspace" {
  value = terraform.workspace
}

output "env" {
  value = local.env
}

output "project_id" {
  value = trimprefix(data.google_project.default.id, "projects/")
}

output "project_number" {
  value = data.google_project.default.number
}
