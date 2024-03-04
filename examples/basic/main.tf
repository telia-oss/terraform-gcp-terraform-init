data "google_client_config" "default" {}


locals {
  labels = {
    "managed-by" = "terraform"
  }
}

module "terraform_state" {
  source     = "../../"
  project_id = "project-shape-293115"
  location     = "EU"

  labels = {
    "managed-by" = "terraform"
  }
}

output "bucket_url" {
  description = "The Url of the statebucket"
  value       = module.terraform_state.bucket_url
}

output "bucket_name" {
  description = "The Url of the statebucket"
  value       = module.terraform_state.bucket_name
}

output "backend_config" {
  description = "Terraform backend configuration snippet for using this bucket as the state backend."
  value       = module.terraform_state.backend_config
}
