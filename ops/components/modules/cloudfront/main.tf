resource "aws_cloudfront_distribution" "website_cloudfront_distribution" {
  origin {
    domain_name              = var.s3_bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.website_oac.id
    origin_id                = var.s3_bucket_id
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
    target_origin_id       = var.s3_bucket_id
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.acm_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}

resource "aws_cloudfront_origin_access_control" "website_oac" {
  name                              = var.s3_bucket_regional_domain_name
  description                       = "Origin Access Control for ${var.environment} environment"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

data "aws_cloudfront_cache_policy" "website_cache_policy" {
  name = var.cache_policy_name
}
