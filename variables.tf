variable "project_id" {
  description = "The GCP project ID. If not provided, the default project from the provider's configuration will be used."
  type        = string
  default     = null
}

variable "location" {
  description = "The location for the GCS bucket."
  type        = string
  default     = null
}

variable "bucket_name" {
  description = "Custom name for the GCS bucket. If not provided, a name will be generated based on the project ID and a suffix."
  type        = string
  default     = null
}

variable "storage_class" {
  description = "The storage class of the GCS bucket."
  type        = string
  default     = "STANDARD"
  validation {
    condition     = contains(["STANDARD", "NEARLINE", "COLDLINE", "ARCHIVE"], var.storage_class)
    error_message = "The storage_class must be one of STANDARD, NEARLINE, COLDLINE, or ARCHIVE."
  }
}

variable "labels" {
  description = "A map of labels to assign to the bucket."
  type        = map(string)
  default     = {}
}

variable "uniform_bucket_level_access" {
  description = "Enables Uniform Bucket Level Access on the bucket."
  type        = bool
  default     = true
}

variable "versioning" {
  description = "Enables versioning for the GCS bucket."
  type        = bool
  default     = true
}

variable "log_bucket" {
  description = "The name of the bucket where access logs should be stored. If empty, logging is disabled."
  type        = string
  default     = null
}

variable "log_object_prefix" {
  description = "The object prefix for the stored access logs."
  type        = string
  default     = "logs"
}

variable "encryption" {
  description = "Set to true to enable server-side encryption using a KMS key. If 'kms_key' is not provided, a new key will be created if 'create_kms_key' is true."
  type        = bool
  default     = false
}

variable "create_kms_key" {
  description = "Set to true to create a new KMS key if no existing key is provided and encryption is enabled."
  type        = bool
  default     = false
}

variable "kms_key" {
  description = "The self-link of an existing KMS CryptoKey to use for encryption. If empty and 'create_kms_key' is true, a new key will be created."
  type        = string
  default     = null
}

variable "key_region" {
  description = "The location of the KMS key ring. If not provided, the global location will be used."
  type        = string
  default     = null
}

variable "retention_policy_retention_period" {
  description = "The retention period for the bucket in seconds. If not set, no retention policy will be applied."
  type        = number
  default     = null
}

variable "retention_policy_is_locked" {
  description = "Specifies if the retention policy is locked. Once locked, it cannot be removed or reduced."
  type        = bool
  default     = false
}
