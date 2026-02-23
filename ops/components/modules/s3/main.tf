resource "aws_s3_bucket" "website_s3_bucket" {
  bucket        = var.bucket_name
  force_destroy = var.force_destroy
  tags = {
    Environment = var.environment
    Project     = "personal-website"
  }
}

# S3 bucket policy for CloudFront access
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
      values   = [var.cloudfront_distribution_arn]
    }
  }
}





