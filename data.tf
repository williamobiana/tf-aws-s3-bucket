
locals {
  prefix      = "${local.environment}-${var.client_id}"
  environment = var.environment == null ? terraform.workspace : var.environment
  default_tags = {
    client        = var.client_id
    deployment_id = var.deployment_id
    environment   = local.environment
    owner         = var.owner
  }
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "bucket" {
  statement {
    sid     = "AllowSSLRequestsOnly"
    actions = ["s3:*"]
    effect  = "Deny"
    resources = [
      aws_s3_bucket.bucket.arn,
      "${aws_s3_bucket.bucket.arn}/*"
    ]
    condition {
      test     = "Bool"
      values   = ["false"]
      variable = "aws:SecureTransport"
    }
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
  source_policy_documents = var.bucket_policy
}
