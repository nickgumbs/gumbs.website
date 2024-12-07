variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Bucket Name"
  type        = string
  default     = "example-bucket"
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "staging"
}

variable "root_domain" {
  description = "Root Domain for Website"
  type        = string
  default     = "example.com"
}

variable "cache_policy_name" {
  description = "Cloudfront Cache Policy Name"
  type        = string
  default     = "Managed-CachingOptimized"
}

variable "index_page" {
  description = "Root Object for Static Website"
  type        = string
  default     = "index.html"
}
