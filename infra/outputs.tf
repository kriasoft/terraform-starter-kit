# Output Values
# https://www.terraform.io/language/values/outputs

output "workspace" {
  value = terraform.workspace
}

output "env" {
  value = local.env
}

output "project" {
  value = trimprefix(data.google_project.default.id, "projects/")
}

output "project_number" {
  value = data.google_project.default.number
}

output "cloudflare" {
  value = {
    zone = {
      id     = cloudflare_zone.default.id
      status = cloudflare_zone.default.status
    }
  }
}
