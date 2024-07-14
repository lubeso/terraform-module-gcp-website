resource "random_id" "default" {
  # Required arguments
  byte_length = 2

  # Optional arguments
  prefix = "${var.website_name}-"
}

resource "google_storage_bucket" "website" {
  # Required arguments
  name     = random_id.default.hex
  location = upper(var.region)

  # Optional arguments
  force_destroy = true
  project       = var.project
  storage_class = "STANDARD"
  website { main_page_suffix = "index.html" }
}

module "website_bucket_iam" {
  # Source configuration
  source  = "terraform-google-modules/iam/google//modules/storage_buckets_iam"
  version = "~> 7.7.1"

  # Required inputs
  # Nothing to do here...

  # Optional inputs
  storage_buckets = [google_storage_bucket.public.name]
  bindings        = { "roles/storage.objectViewer" = ["allUsers"] }
}

resource "google_compute_backend_bucket" "website" {
  # Required arguments
  bucket_name = google_storage_bucket.public.name
  name        = var.website_name

  # Optional arguments
  enable_cdn = true
}
