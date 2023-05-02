# AWS S3 Bucket Terraform Module

[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

## Overview
A Terraform module for creating an S3 bucket. The server side encription is enabled by default using "AES256" SSE algorithm.
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client_id"></a> [client_id](#input_client_id) | Client ID - use dsol for internal resources. Used in all name prefixes. | `string` | n/a | yes |
| <a name="input_deployment_id"></a> [deployment_id](#input_deployment_id) | The deployment/application ID to be used across stack resources. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input_name) | Name for the bucket. | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input_owner) | Technical owner of the resources. | `string` | n/a | yes |
| <a name="input_acl"></a> [acl](#input_acl) | Access Control List (ACL) config for the bucket. | `string` | `"private"` | no |
| <a name="input_bucket_policy"></a> [bucket_policy](#input_bucket_policy) | A list of IAM policy objects in JSON format. | `list(string)` | `[]` | no |
| <a name="input_environment"></a> [environment](#input_environment) | Deployment environment, defaults to terraform.workspace. Used in all name prefixes. | `string` | `null` | no |
| <a name="input_kms_key_id"></a> [kms_key_id](#input_kms_key_id) | The ID of an AWS KMS CMK that will be used to encrypt Bucket Objects. SSE-S3 is applied by default. | `string` | `null` | no |
| <a name="input_lifecycle_config"></a> [lifecycle_config](#input_lifecycle_config) | Configuration object which defines the lifecycle settings for the S3 Bucket. | <pre>object({<br>    retention_in_days = optional(number)<br>    noncurrent_retention_in_days = optional(number)<br>    prefix  = string<br>  })</pre> | `null` | no |
| <a name="input_version_bucket"></a> [version_bucket](#input_version_bucket) | Set to true if you want to switch versioning on for the bucket. | `bool` | `false` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output_arn) | ARN of the S3 Bucket. |
| <a name="output_domain_name"></a> [domain_name](#output_domain_name) | Regional domain name of the S3 Bucket. |
| <a name="output_id"></a> [id](#output_id) | ID of the S3 Bucket. |
## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_policy.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3control_bucket_lifecycle_configuration.lifecycle](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3control_bucket_lifecycle_configuration) | resource |
## Modules

No modules.
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
