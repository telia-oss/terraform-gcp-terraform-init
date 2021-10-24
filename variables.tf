variable "region" {
  type        = string
  description = "The region to operate under."
  default     = ""
}
variable "project_id" {
  type        = string
  description = "The ID of the project to apply any resources to"
}
variable "bucket_name" {
  type        = string
  description = "The name of the Google Storage Bucket to create"
}

variable "log_bucket" {
  description = "The name of the bucket to which access logs for this bucket should be written. If this is not supplied then no access logs are written."
  default     = ""
}

variable "log_object_prefix" {
  description = "The prefix for access log objects. If this is not provided then GCS defaults it to the name of the source bucket."
  default     = ""
}

variable "kms_key_sl" {
  description = "A self_link to a Cloud KMS key to be used to encrypt objects in this bucket, see also: https://cloud.google.com/storage/docs/encryption/using-customer-managed-keys. If this is not supplied then default encryption is used."
  default     = ""
}

variable "versioning" {
  description = "If true then versioning is enabled for all objects in this bucket."
  default     = false
}

variable "storage_class" {
  type        = string
  description = "The target Storage Class of objects affected by this Lifecycle Rule. Supported values include: STANDARD, MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, ARCHIVE."
  default     = "STANDARD"
}

variable "uniform_bucket_level_access" {
  description = "When you enable uniform bucket-level access on a bucket, Access Control Lists (ACLs) are disabled, and only bucket-level Identity and Access Management (IAM) permissions grant access to that bucket and the objects it contains."
  default     = true
}

variable "labels" {
  description = "A set of key/value label pairs to assign to the bucket. See also:https://cloud.google.com/resource-manager/docs/creating-managing-labels#requirements."
  default     = {}
}

variable "force_destroy" {
  description = "When deleting a bucket, this boolean option will delete all contained objects. If you try to delete a bucket that contains objects, Terraform will fail that run."
  default     = false
}

variable "retention_policy_is_locked" {
  description = "If set to true, the bucket will be locked and any changes to the bucket's retention policy will be permanently restricted. Caution: Locking a bucket is an irreversible action."
  default     = "false"
}
variable "retention_policy_retention_period" {
  description = "The period of time, in seconds, that objects in the bucket must be retained and cannot be deleted, overwritten, or archived. The value must be less than 3,155,760,000 seconds. If this is supplied then a bucket retention policy will be created."
  default     = ""
}
