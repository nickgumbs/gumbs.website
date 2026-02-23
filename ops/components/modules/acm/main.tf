resource "aws_acm_certificate" "website_certificate" {
  domain_name               = var.root_domain
  key_algorithm             = "RSA_2048"
  validation_method         = "DNS"
  subject_alternative_names = ["www.${var.root_domain}"]
  options {
    certificate_transparency_logging_preference = "ENABLED"
  }
}

# Create Route53 CNAME records associated with ACM certificate
resource "aws_route53_record" "cname_records" {
  for_each = { for dvo in aws_acm_certificate.website_certificate.domain_validation_options : dvo.domain_name => dvo }

  zone_id = var.zone_id
  name    = each.value.resource_record_name
  type    = each.value.resource_record_type
  records = [each.value.resource_record_value]
  ttl     = 300
}

resource "aws_acm_certificate_validation" "validation" {
  certificate_arn         = aws_acm_certificate.website_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.cname_records : record.fqdn]
}
