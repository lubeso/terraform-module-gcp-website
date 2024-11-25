output "backend_bucket_id" {
  # Required arguments
  value = google_compute_backend_bucket.website.id
  # Optional arguments
  description = "Identifier for the backend bucket"
}
