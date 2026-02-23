variable "environment" {
  description = "Environment to deploy"
  type        = string
  nullable    = false

  validation {
    condition     = contains(["production", "staging"], var.environment)
    error_message = "Environment must be 'production' or 'staging'."
  }
}

variable "bucket_name" {
  description = "Bucket Name"
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
  description = "Cloudfront Cache Policy Name"
  type        = string
}

variable "index_page" {
  description = "Root Object for Static Website (e.g., index.html)"
  type        = string
  default     = "index.html"
}

variable "ddb_jokes_table_data" {
  description = "DynamoDB Jokes table data"
  type = object({
    name = string
    primary_key = object({
      name = string
      type = string
    })
  })
}

variable "ddb_visitor_table_data" {
  description = "DynamoDB Visitor Count table data"
  type = object({
    name = string
    primary_key = object({
      name = string
      type = string
    })
  })
}

variable "force_destroy" {
  description = "Allow the S3 bucket to be destroyed even when non-empty. Set true only for non-production environments."
  type        = bool
  default     = false
}
