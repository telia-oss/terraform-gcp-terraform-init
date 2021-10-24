output "bucket_url" {
  description = "The Url of the statebucket"
  value       = module.basic.bucket_url
}

output "bucket_name" {
  description = "The Url of the statebucket"
  value       = module.basic.bucket_name
}

output "remote_state" {
  description = "The remote state configuration"
  value       = module.basic.remote_state
}
