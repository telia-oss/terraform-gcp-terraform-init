output "bucket_url" {
  description = "The Url of the statebucket"
  value       = google_storage_bucket.statebucket.url
}

output "bucket_name" {
  description = "The Url of the statebucket"
  value       = google_storage_bucket.statebucket.name
}

output "backend_config" {
  description = "Terraform backend configuration snippet for using this bucket as the state backend."
  value       = <<EOF
terraform {
  backend "gcs" {
    bucket  = "${google_storage_bucket.statebucket.name}"
    prefix  = "terraform/state" # Adjust the prefix as needed
  }
}
EOF
}
