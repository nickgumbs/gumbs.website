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
      values   = [var.cf_distribution_arn]
    }
  }
}

resource "aws_s3_object" "website_files" {
  for_each     = fileset(var.dist_filepath, "**")
  bucket       = aws_s3_bucket.website_s3_bucket.id
  key          = each.key
  content_type = lookup(local.content_types, reverse(split(".", each.key))[0], "text/plain")
  source       = "${var.dist_filepath}/${each.value}"
  etag         = filemd5("${var.dist_filepath}/${each.value}")
}




