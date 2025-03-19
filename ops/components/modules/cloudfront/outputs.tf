output "cf_distribution_arn" {
  value = aws_cloudfront_distribution.website_cloudfront_distribution.arn
}

output "cf_domain_name" {
  value = aws_cloudfront_distribution.website_cloudfront_distribution.domain_name
}

output "cf_hosted_zone_id" {
  value = aws_cloudfront_distribution.website_cloudfront_distribution.hosted_zone_id
}
