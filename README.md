# Terraform GCP Terraform Init Module

This Terraform module creates all necessary components for managing Terraform state remotely in Google Cloud Storage (GCS). It's designed to help teams use GCS as a backend for Terraform state to enable better collaboration and state management.

## Features

- **GCS Bucket**: Creates a versioned GCS bucket for storing Terraform state files.
- **Encryption**: Supports encryption using Google Cloud KMS.
- **Access Control**: Implements uniform bucket-level access to enhance security.
- **Logging**: Optional logging configuration for access logs.
- **Retention Policy**: Supports setting a retention policy on the bucket.

## Prerequisites

- Terraform 0.14 or newer
- A Google Cloud project
- Appropriate permissions to create GCS buckets and KMS keys in the project

## Usage

To use this module in your Terraform configuration, add the following:

```hcl
module "terraform_state" {
  source  = "telia-oss/terraform-gcp-terraform-init"
  project_id = "project-shape-293115"
  location     = "EU"

  labels = {
    "managed-by" = "terraform"
  }
}
```

## Inputs

| Variable Name                       | Description                                                                                                                         | Type          | Default    | Validation/Condition                                    |
| ----------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- | ------------- | ---------- | ------------------------------------------------------- |
| `project_id`                        | The GCP project ID. If not provided, the default project from the provider's configuration will be used.                            | `string`      | `null`     | N/A                                                     |
| `location`                            | The region where the bucket will be created. If not provided, the default region from the provider's configuration will be used.    | `string`      | `null`     | N/A                                                     |
| `bucket_name`                       | Custom name for the GCS bucket. If not provided, a name will be generated based on the project ID and a suffix.                     | `string`      | `null`     | N/A                                                     |
| `storage_class`                     | The storage class of the GCS bucket.                                                                                                | `string`      | `STANDARD` | Must be one of STANDARD, NEARLINE, COLDLINE, or ARCHIVE |
| `labels`                            | A map of labels to assign to the bucket.                                                                                            | `map(string)` | `{}`       | N/A                                                     |
| `uniform_bucket_level_access`       | Enables Uniform Bucket Level Access on the bucket.                                                                                  | `bool`        | `true`     | N/A                                                     |
| `versioning`                        | Enables versioning for the GCS bucket.                                                                                              | `bool`        | `false`    | N/A                                                     |
| `log_bucket`                        | The name of the bucket where access logs should be stored. If empty, logging is disabled.                                           | `string`      | `null`     | N/A                                                     |
| `log_object_prefix`                 | The object prefix for the stored access logs.                                                                                       | `string`      | `"logs"`   | N/A                                                     |
| `encryption`                        | Set to true to enable server-side encryption using a KMS key. If 'kms_key' is not provided, a new key will be created if enabled.   | `bool`        | `false`    | N/A                                                     |
| `create_kms_key`                    | Set to true to create a new KMS key if no existing key is provided and encryption is enabled.                                       | `bool`        | `false`    | N/A                                                     |
| `kms_key`                           | The self-link of an existing KMS CryptoKey to use for encryption. If empty and 'create_kms_key' is true, a new key will be created. | `string`      | `null`     | N/A                                                     |
| `retention_policy_retention_period` | The retention period for the bucket in seconds. If not set, no retention policy will be applied.                                    | `number`      | `null`     | Must be a non-negative number                           |
| `retention_policy_is_locked`        | Specifies if the retention policy is locked. Once locked, it cannot be removed or reduced.                                          | `bool`        | `false`    | N/A                                                     |

This table provides a clear and concise overview of each variable, making it easier to understand the configuration options available for the Terraform module.

## Outputs

| Name                | Description                              |
| ------------------- | ---------------------------------------- |
| `bucket_name`       | The name of the created GCS bucket.      |
| `backend_config`    | The backend configuration for Terraform. |


## Examples

For example usage of this module, see the `examples/basic` directory.

## Contributing

Contributions to this module are welcome! Please see the contributing guidelines for more details.

## License

This module is licensed under the MIT License - see the LICENSE file for details.
