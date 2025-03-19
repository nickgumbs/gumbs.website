variable "environment" {
  description = "The environment (e.g., production, staging)"
  type        = string
}

variable "root_domain" {
  description = "The root domain name (e.g., example.com)"
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "dist_filepath" {
  description = "Path to Dist files"
  type        = string
}

variable "cf_distribution_arn" {
  description = "Cloudfront Distribution ARN"
  type        = string
}

