## Usage

```hcl
module "s3_bucket" {
  source        = "git::https://github.com/mudano-data-solutions/tf-aws-s3-bucket.git"
  client_id     = var.client_id
  deployment_id = var.deployment_id
  environment   = var.environment
  owner         = var.owner

  bucket_policy  = data.aws_iam_policy_document.bucket_policy.json
  name           = "containers-source-code"
  version_bucket = true
}
```

## Documentation
We use a library called `terraform-docs` for automatically generating documentation for the variables, outputs, resources, and sub-modules defined within a Terraform module.   
The output from `terraform-docs` is wrapped between `HEADER.md` and `FOOTER.md` files which include custom module documentation and usage guidelines.

To ensure our documentation remains up-to-date, it is important that each time changes are made to a module the docs are updated by cd'ing into the module directory and running the following command:  

`terraform-docs --config docs/terraform-docs.yaml markdown --escape=false . > README.md`