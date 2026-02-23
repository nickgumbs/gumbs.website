output "acm_certificate_arn" {
  value       = aws_acm_certificate.website_certificate.arn
  description = "ARN for ACM Certificate"
}
