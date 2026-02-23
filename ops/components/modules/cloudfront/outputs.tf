output "cf_distribution_id" {
  description = "CloudFront distribution ID"
  value       = aws_cloudfront_distribution.website_cloudfront_distribution.id
}

output "cf_distribution_arn" {
  description = "CloudFront distribution ARN"
  value       = aws_cloudfront_distribution.website_cloudfront_distribution.arn
}

output "cf_domain_name" {
  description = "CloudFront distribution domain name"
  value       = aws_cloudfront_distribution.website_cloudfront_distribution.domain_name
}

output "cf_hosted_zone_id" {
  description = "CloudFront hosted zone ID (for Route53 alias records)"
  value       = aws_cloudfront_distribution.website_cloudfront_distribution.hosted_zone_id
}
