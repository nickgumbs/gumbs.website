variable "environment" {
  description = "The environment (e.g., production, staging)"
  type        = string
}

variable "root_domain" {
  description = "The root domain name (e.g., example.com)"
  type        = string
}

variable "index_page" {
  description = "The default root object for the website"
  type        = string
}

variable "cache_policy_name" {
  description = "The cache policy name for CloudFront"
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "s3_bucket_regional_domain_name" {
  description = "The Regional Domain name of the S3 bucket"
  type        = string
}

variable "acm_certificate_arn" {
  description = "ARN for ACM Certificate"
  type        = string
}

variable "s3_bucket_id" {
  description = "S3 Bucket ID"
  type        = string
}
