variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

# Production Variables
variable "bucket_name" {
  description = "Bucket Name for production"
  type        = string
  default     = "example-bucket"
}

variable "root_domain" {
  description = "Root Domain for Website (e.g., example.com)"
  type        = string
  default     = "example.com"
}

variable "hosted_zone_name" {
  description = "Hosted Zone name (may require a . at the end)"
  type        = string
  default     = "example.com."
}

variable "cache_policy_name" {
  description = "Cloudfront Cache Policy Name for production"
  type        = string
}

# Staging Variables
variable "staging_cache_policy_name" {
  description = "Cloudfront Cache Policy Name for staging"
  type        = string
}

variable "staging_root_domain" {
  description = "Staging Domain Name (e.g., staging.example.com)"
  type        = string
}

variable "staging_bucket_name" {
  description = "Staging Bucket Name"
  type        = string
}

variable "staging_index_page" {
  description = "Root Object for Staging Website (e.g., index.html)"
  type        = string
}

variable "staging_dist_filepath" {
  description = "Relative Path to Dist files for staging"
  type        = string
}

# Common Variables
variable "index_page" {
  description = "Root Object for Static Website (e.g., index.html)"
  type        = string
  default     = "index.html"
}

variable "dist_filepath" {
  description = "Relative Path to Dist files for production"
  type        = string
}
