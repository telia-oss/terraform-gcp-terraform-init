data "google_client_config" "default" {}


locals {
  bucket_name = var.bucket_name == "" ? format("%s-%s-%s", "terraform-state", data.google_client_config.default.project, random_string.randomstring.result) : var.bucket_name
}

module "basic" {
  source      = "../../"
  project_id  = var.project_id
  bucket_name = local.bucket_name
}

data "google_project" "project" {
}


resource "random_string" "randomstring" {
  length      = 25
  min_lower   = 15
  min_numeric = 10
  special     = false
}
