
variable "client_id" {
  description = "Client ID - use dsol for internal resources. Used in all name prefixes."
  type        = string
}

variable "deployment_id" {
  description = "The deployment/application ID to be used across stack resources."
  type        = string
}

variable "environment" {
  type        = string
  description = "Deployment environment, defaults to terraform.workspace. Used in all name prefixes."
  default     = null
}

variable "owner" {
  description = "Technical owner of the resources."
  type        = string
}


variable "acl" {
  description = "Access Control List (ACL) config for the bucket."
  default     = "private"
  type        = string
}

variable "name" {
  description = "Name for the bucket."
  type        = string
}

variable "bucket_policy" {
  description = "A list of IAM policy objects in JSON format."
  default     = []
  type        = list(string)
}

variable "kms_key_id" {
  description = "The ID of an AWS KMS CMK that will be used to encrypt Bucket Objects. SSE-S3 is applied by default."
  default     = null
  type        = string
}

variable "lifecycle_config" {
  description = "Configuration object which defines the lifecycle settings for the S3 Bucket."
  default     = null
  type        = object({
    retention_in_days = optional(number)
    noncurrent_retention_in_days = optional(number)
    prefix  = string
  })
  validation {
    condition = var.lifecycle_config != null ? var.lifecycle_config["retention_in_days"] != null || var.lifecycle_config["noncurrent_retention_in_days"] != null : true
    error_message = "You must specify values for `retention_in_days` and/or `noncurrent_retention_in_days`."
  }
}

variable "version_bucket" {
  description = "Set to true if you want to switch versioning on for the bucket."
  default     = false
  type        = bool
}
