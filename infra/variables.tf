# Environment variables and secrets
# https://www.terraform.io/language/values/variables
#
# You can safely create/update variable values
# through the Terraform Cloud dashboard found at:
#
#   https://app.terraform.io/app/<org>/workspaces/app-<env>
#

# Cloudflare Credentials
# https://dash.cloudflare.com
# https://dash.cloudflare.com/profile/api-tokens

variable "CLOUDFLARE_ACCOUNT_ID" {
  default = "xxxxx"
}

# Requires an API token with the following permissions:
#   • Zone > DNS (Edit)
#   • Zone > Zone Settings (Edit)
variable "CLOUDFLARE_API_TOKEN" {
  default   = "xxxxx"
  sensitive = true
}
