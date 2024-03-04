data "google_client_config" "current" {}

locals {
  project_id        = try(var.project_id, data.google_client_config.current.project)
  region            = data.google_client_config.current.region
  bucket_name_infix = "terraform-state"

  bucket_name_suffix = var.bucket_name != null ? var.bucket_name : random_string.bucket_suffix.result
  full_bucket_name   = format("%s-%s-%s", local.project_id, local.bucket_name_infix, local.bucket_name_suffix)
  kms_key_self_link  = var.encryption && var.kms_key == null && var.create_kms_key ? google_kms_crypto_key.crypto_key[0].name : var.kms_key
}

resource "random_string" "bucket_suffix" {
  length      = 10
  min_lower   = 0
  min_numeric = 10
  special     = false
  keepers = {
    project_id = local.project_id
  }
}

resource "google_kms_key_ring" "key_ring" {
  for_each = var.create_kms_key && var.encryption && var.kms_key == null ? { key_ring = 1 } : {}
  name     = "${local.bucket_name_infix}-key-ring"
  location = var.key_region != null ? var.key_region : data.google_client_config.current.region
}

resource "google_kms_crypto_key" "crypto_key" {
  for_each = var.create_kms_key && var.encryption && var.kms_key == null ? { crypto_key = 1 } : {}
  name     = "${local.bucket_name_infix}-crypto-key"
  key_ring = google_kms_key_ring.key_ring[each.key].self_link
}

resource "google_storage_bucket" "statebucket" {
  name                        = local.full_bucket_name
  project                     = local.project_id
  location                    = var.location
  storage_class               = var.storage_class
  force_destroy               = true
  labels                      = var.labels
  uniform_bucket_level_access = var.uniform_bucket_level_access

  versioning {
    enabled = var.versioning
  }

  dynamic "logging" {
    for_each = var.log_bucket != null ? { log_bucket = 1 } : {}
    content {
      log_bucket        = var.log_bucket
      log_object_prefix = var.log_object_prefix
    }
  }

  dynamic "encryption" {
    for_each = var.encryption && var.kms_key != null ? { encryption = 1 } : {}
    content {
      default_kms_key_name = local.kms_key_self_link
    }
  }

  dynamic "retention_policy" {
    for_each = var.retention_policy_retention_period != null ? { retention_policy = 1 } : {}
    content {
      is_locked        = var.retention_policy_is_locked
      retention_period = var.retention_policy_retention_period
    }
  }
}

resource "google_storage_bucket_acl" "statebucket_acl" {
  for_each       = var.uniform_bucket_level_access ? {} : { acl = 1 }
  bucket         = google_storage_bucket.statebucket.name
  predefined_acl = "private"
}
