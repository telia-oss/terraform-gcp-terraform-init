output "bucket_url" {
  description = "The Url of the statebucket"
  value       = google_storage_bucket.statebucket.url
}

output "bucket_name" {
  description = "The Url of the statebucket"
  value       = google_storage_bucket.statebucket.name
}

output "remote_state" {
  description = "The remote state configuration"
  value       = data.template_file.remote_state.rendered
}
