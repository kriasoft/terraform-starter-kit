# Local Values
# https://www.terraform.io/language/values/locals

locals {
  workspace_prefix = "app-"

  # The name of the selected workspace environment
  #   • `prod` — production
  #   • `test` — test / QA
  #   • `dev`  — local development
  env = trimprefix(terraform.workspace, local.workspace_prefix)

  # Helper variables for detecting the selected workspace environment
  is_production  = local.env == "prod"
  is_test        = local.env == "test"
  is_development = local.env == "dev"

  # Application URL
  domain   = "example.com"
  hostname = local.is_production ? local.domain : "${local.env}.${local.domain}"
  origin   = "https://${local.hostname}"

  // Google Cloud Project
  // https://cloud.google.com/resource-manager/docs/creating-managing-projects
  project = {
    "prod" = "example"
    "test" = "example-test"
    "dev"  = "example-dev"
  }[local.env]

  # Google Cloud Location
  # https://cloud.google.com/compute/docs/regions-zones
  region = "us-central1"
  zone   = "us-central1-f"
}
