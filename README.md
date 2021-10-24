# Terraform Init

A module for setting up a secure terraform state bucket with GC These resources should never be deleted, so storing state for this deployment is not strictly necessary. Creates the following resources:

## Usage

Include this repository as a module in your existing terraform code:

```hcl
module "basic" {
  source      = "../../"
  project_id  = var.project_id
  bucket_name = local.bucket_name
}
```
