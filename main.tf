
resource "aws_s3_bucket" "bucket" {
  bucket        = "${data.aws_caller_identity.current.id}-${local.prefix}-${var.name}"
  force_destroy = true
  tags = merge(
    local.default_tags,
    { "Name" : "${data.aws_caller_identity.current.id}-${local.prefix}-${var.name}" }
  )
}

resource "aws_s3_bucket_acl" "acl" {
  bucket  = aws_s3_bucket.bucket.id
  acl     = var.acl
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket  = aws_s3_bucket.bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.kms_key_id == null ? "AES256" : "aws:kms"
      kms_master_key_id = var.kms_key_id
    }
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  count = var.version_bucket == true ? 1 : 0

  bucket  = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3control_bucket_lifecycle_configuration" "lifecycle" {
  count = var.lifecycle_config != null ? 1 : 0

  bucket = aws_s3_bucket.bucket.id
  dynamic "rule" {
    for_each = var.lifecycle_config["retention_in_days"] != null ? [1] : []
    content {
      id = "ExpireCurrentObjects"
      expiration {
        days = var.lifecycle_config["retention_in_days"]
      }
      filter {
        prefix = coalesce(var.lifecycle_config["prefix"], "")
      }
    }
  }
  dynamic "rule" {
    for_each = var.lifecycle_config["noncurrent_retention_in_days"] != null ? [1] : []
    content {
      id = "ExpireNoncurrentObjects"
      noncurrent_version_expiration {
        noncurrent_days = var.lifecycle_config["noncurrent_retention_in_days"]
      }
      filter {
        prefix = coalesce(var.lifecycle_config["prefix"], "")
      }
    }
  }
}

resource "aws_s3_bucket_policy" "bucket" {
  bucket = aws_s3_bucket.bucket.bucket
  policy = data.aws_iam_policy_document.bucket.json
}
