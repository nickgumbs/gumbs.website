locals {
  content_types = {
    css         = "text/css"
    html        = "text/html"
    ico         = "image/x-icon"
    jpeg        = "image/jpeg"
    jpg         = "image/jpeg"
    json        = "application/json"
    js          = "application/javascript"
    map         = "application/json"
    pdf         = "application/pdf"
    png         = "image/png"
    svg         = "image/svg+xml"
    webmanifest = "application/manifest+json"
    xml         = "application/xml"
  }
}

resource "aws_s3_bucket" "website_s3_bucket" {
  bucket        = var.bucket_name
  force_destroy = true
  tags = {
    Environment = var.environment
    Project     = "personal-website"
  }
}

resource "aws_s3_bucket_policy" "website_s3_bucket_policy" {
  bucket = aws_s3_bucket.website_s3_bucket.id
  policy = data.aws_iam_policy_document.allow_access_from_cloudfront_distribution.json
}

data "aws_iam_policy_document" "allow_access_from_cloudfront_distribution" {
  version = "2012-10-17"
  statement {
    sid     = "AllowCloudFrontServicePrincipal"
    effect  = "Allow"
    actions = ["s3:GetObject"]

    resources = [
      "${aws_s3_bucket.website_s3_bucket.arn}/*"
    ]
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.website_cloudfront_distribution.arn]
    }
  }
}

# Upload built files from /dist
resource "aws_s3_object" "website_files" {
  for_each     = fileset(var.dist_filepath, "**")
  bucket       = aws_s3_bucket.website_s3_bucket.id
  key          = each.key
  content_type = lookup(local.content_types, reverse(split(".", each.key))[0], "text/plain")
  source       = "${var.dist_filepath}/${each.value}"
  etag         = filemd5("${var.dist_filepath}/${each.value}")
}

resource "aws_acm_certificate" "website_certificate" {
  domain_name               = var.root_domain
  key_algorithm             = "RSA_2048"
  validation_method         = "DNS"
  subject_alternative_names = ["www.${var.root_domain}"]
  options {
    certificate_transparency_logging_preference = "ENABLED"
  }
}

resource "aws_cloudfront_distribution" "website_cloudfront_distribution" {
  origin {
    domain_name              = aws_s3_bucket.website_s3_bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.website_oac.id
    origin_id                = aws_s3_bucket.website_s3_bucket.id
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Distribution for ${var.environment} website"
  default_root_object = var.index_page

  aliases = ["www.${var.root_domain}", var.root_domain]

  default_cache_behavior {
    cache_policy_id        = data.aws_cloudfront_cache_policy.website_cache_policy.id
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    viewer_protocol_policy = "redirect-to-https"
    target_origin_id       = aws_s3_bucket.website_s3_bucket.id
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.website_certificate.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}

resource "aws_cloudfront_origin_access_control" "website_oac" {
  name                              = aws_s3_bucket.website_s3_bucket.bucket_regional_domain_name
  description                       = "Origin Access Control for ${var.environment} environment"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

data "aws_cloudfront_cache_policy" "website_cache_policy" {
  name = var.cache_policy_name
}

resource "aws_route53_record" "cname_records" {
  for_each = { for dvo in aws_acm_certificate.website_certificate.domain_validation_options : dvo.domain_name => dvo }

  zone_id = var.zone_id
  name    = each.value.resource_record_name
  type    = each.value.resource_record_type
  records = [each.value.resource_record_value]
  ttl     = 300
}

resource "aws_route53_record" "subdomain_record" {
  zone_id = var.zone_id
  name    = "www.${var.root_domain}"
  type    = "CNAME"
  records = [var.root_domain]
  ttl     = 300
}

resource "aws_acm_certificate_validation" "validation" {
  certificate_arn         = aws_acm_certificate.website_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.cname_records : record.fqdn]
}

resource "aws_route53_record" "alias" {
  zone_id = var.zone_id
  name    = var.root_domain
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.website_cloudfront_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.website_cloudfront_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "alias_ipv6" {
  zone_id = var.zone_id
  name    = var.root_domain
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.website_cloudfront_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.website_cloudfront_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}
