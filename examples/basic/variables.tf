variable "project_id" {
  type        = string
  description = "The ID of the project to apply any resources to"
  default     = "seismic-shape-293115"
}

variable "bucket_name" {
  type        = string
  description = "The name of the Google Storage Bucket to create"
  default     = ""
}
