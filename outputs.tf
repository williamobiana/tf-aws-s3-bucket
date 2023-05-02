
output "arn" {
  description = "ARN of the S3 Bucket."
  value       = aws_s3_bucket.bucket.arn
}

output "id" {
  description = "ID of the S3 Bucket."
  value       = aws_s3_bucket.bucket.id
}

output "domain_name" {
  description = "Regional domain name of the S3 Bucket."
  value       = aws_s3_bucket.bucket.bucket_regional_domain_name
}
