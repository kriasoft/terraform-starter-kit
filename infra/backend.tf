# The block below configures Terraform to use the "remote" backend with Terraform Cloud.
# For more information, see https://www.terraform.io/language/settings/backends/remote

terraform {
  backend "remote" {
    # Terraform Cloud Organization
    # https://app.terraform.io/app/settings/organizations
    organization = "example"

    workspaces {
      prefix = local.workspace_prefix
    }
  }
}
