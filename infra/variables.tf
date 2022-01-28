# Input Variables
# https://www.terraform.io/language/values/variables
#
# You can add/update variables through the Terraform Cloud dashboard:
#
#   https://app.terraform.io/app/<org>/workspaces/app-<env>
#
variable "CLOUDFLARE_ACCOUNT_ID" {
  description = "Cloudflare Account ID"
  default     = "xxxxx"
}

variable "CLOUDFLARE_ZONE_ID" {
  description = "Cloudflare Zone ID"
  default     = "xxxxx"
}

variable "CLOUDFLARE_API_TOKEN" {
  description = "Cloudflare API Token"
  default     = "xxxxx"
  sensitive   = true
}
