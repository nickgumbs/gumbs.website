output "s3_bucket_regional_domain_name" {
  description = "S3 bucket regional domain name"
  value       = aws_s3_bucket.website_s3_bucket.bucket_regional_domain_name
}

output "s3_bucket_id" {
  description = "S3 bucket ID"
  value       = aws_s3_bucket.website_s3_bucket.id
}

output "s3_bucket_arn" {
  description = "S3 bucket ARN"
  value       = aws_s3_bucket.website_s3_bucket.arn
}
