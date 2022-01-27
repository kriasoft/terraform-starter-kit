# The block below configures Terraform to use the 'remote' backend with Terraform Cloud.
# For more information, see https://www.terraform.io/language/settings/backends/remote

terraform {
  backend "remote" {
    # Terraform Cloud Organization
    # https://app.terraform.io/app/settings/organizations
    organization = "example"

    workspaces {
      prefix = "app-"
    }
  }
}

locals {
  # The name of the selected environment
  #   • `prod` — production
  #   • `test` — test / QA
  #   • `dev`  — local development
  env = trimprefix(terraform.workspace, "app-")

  # Helper variables to be used for environment detection
  is_prod = local.env == "prod" ? true : false
  is_test = local.env == "test" ? true : false
  is_dev  = local.env == "dev" ? true : false
}
