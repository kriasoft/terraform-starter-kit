# Google Cloud Storage (GCS)
# https://cloud.google.com/storage/docs
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket
#
# NOTE: Creating storage buckets containing a domain in their names
#       requires domain verification in the Google Search Console:
#       https://search.google.com/search-console/users
#
#       Grant `Owner` permission to the `terraform@<project>.iam.gserviceaccount.com`
#       service account used by Terraform Cloud.

# The storage bucket for hosting a single-page web application (SPA)
resource "google_storage_bucket" "website" {
  name     = local.hostname
  location = "US"
  labels   = {}

  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }

  cors {
    origin          = [local.origin]
    method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
    response_header = ["*"]
    max_age_seconds = 3600
  }

  force_destroy = true
}

# The storage bucket for the uploaded user content
# serving as a temporary storage for new files before
# they are moved to a permanent location based on the
# linked resource type (user picture, posted image, etc.)
resource "google_storage_bucket" "upload" {
  name     = local.is_production ? "upload.${local.domain}" : "${local.env}-upload.${local.domain}"
  location = "US-CENTRAL1"
  labels   = {}

  uniform_bucket_level_access = true

  cors {
    origin          = local.is_development ? ["*"] : [local.origin]
    method          = ["GET", "HEAD", "PUT", "OPTIONS"]
    response_header = ["Content-Type", "Access-Control-Allow-Origin"]
    max_age_seconds = 3600
  }

  retention_policy {
    is_locked        = false
    retention_period = 86400
  }

  force_destroy = true
}
