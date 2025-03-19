variable "root_domain" {
  description = "The root domain name (e.g., example.com)"
  type        = string
}

variable "zone_id" {
  description = "The Route 53 hosted zone ID"
  type        = string
}

variable "cf_domain_name" {
  description = "Cloudfront Domain Name"
  type        = string
}

variable "cf_hosted_zone_id" {
  description = "Cloudfront Hosted Zone ID"
  type        = string
}
