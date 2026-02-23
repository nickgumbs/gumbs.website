variable "environment" {
  description = "The environment (e.g., production, staging)"
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "force_destroy" {
  description = "Allow bucket to be destroyed even when non-empty. Set true only for non-production environments."
  type        = bool
  default     = false
}

variable "cloudfront_distribution_arn" {
  description = "ARN of the CloudFront distribution to allow S3 access"
  type        = string
}

