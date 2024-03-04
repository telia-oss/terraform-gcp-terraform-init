# Basic Example

This is an example of how to use the `terraform-gcp-terraform-init` module to create a GCS bucket with default settings.

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

## Prerequisites

- Terraform 0.14 or newer
- A Google Cloud project
- Appropriate permissions to create GCS buckets and KMS keys in the project
- A KMS key if server-side encryption is enabled
- A bucket for storing access logs if logging is enabled
- A Google Cloud project with the necessary permissions to create the resources
- A google cloud sdk session logged in with the necessary permissions
