# Create a GCS Bucket
locals {
  project_id = var.project_id == "" ? data.google_client_config.default.project : var.project_id
  region     = var.region == "" ? data.google_client_config.default.region : var.region

  bucket_name = var.bucket_name == "" ? format("%s-%s", local.project_id, random_string.randomstring.result) : var.bucket_name

}
resource "random_string" "randomstring" {
  length      = 25
  min_lower   = 15
  min_numeric = 10
  special     = false
}

data "google_client_config" "default" {}

resource "google_storage_bucket" "statebucket" {
  project       = local.project_id
  name          = local.bucket_name
  location      = local.region
  force_destroy = true
  storage_class = var.storage_class
  labels        = var.labels

  uniform_bucket_level_access = var.uniform_bucket_level_access

  versioning {
    enabled = var.versioning
  }

  dynamic "logging" {
    for_each = var.log_bucket == "" ? [] : [1]
    content {
      log_bucket        = var.log_bucket
      log_object_prefix = var.log_object_prefix
    }
  }

  dynamic "encryption" {
    for_each = var.kms_key_sl == "" ? [] : [1]
    content {
      default_kms_key_name = var.kms_key_sl
    }
  }

  dynamic "retention_policy" {
    for_each = var.retention_policy_retention_period == "" ? [] : [1]
    content {
      is_locked        = var.retention_policy_is_locked
      retention_period = var.retention_policy_retention_period
    }
  }
}

resource "google_storage_bucket_acl" "statebucket_acl" {

  count  = var.uniform_bucket_level_access == true ? 0 : 1
  bucket = google_storage_bucket.statebucket.name

  predefined_acl = "private"
}
data "template_file" "remote_state" {
  template = file("${path.module}/templates/remote_state.tf.template")

  vars = {
    bucket_name = google_storage_bucket.statebucket.name
  }
}
