output "s3_bucket_id" {
  description = "S3 bucket name for static assets"
  value       = module.s3.s3_bucket_id
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID (used for cache invalidations)"
  value       = module.cloudfront.cf_distribution_id
}

output "cloudfront_domain" {
  description = "CloudFront distribution domain name"
  value       = module.cloudfront.cf_domain_name
}

output "api_base_url" {
  description = "API Gateway base URL for frontend configuration"
  value       = module.apigateway.api_base_url
}
