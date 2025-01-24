module "production_website" {
  source            = "../modules/website"
  environment       = "production"
  index_page        = var.index_page
  cache_policy_name = var.cache_policy_name
  dist_filepath     = var.dist_filepath

  # Production-specific variables
  root_domain = var.root_domain
  bucket_name = "${var.bucket_name}-${random_string.random_id[0].id}"
  zone_id     = data.aws_route53_zone.hosted_zone.id
}

data "aws_route53_zone" "hosted_zone" {
  name         = var.hosted_zone_name
}

resource "random_string" "random_id" {
  length  = 16
  count   = 1
  special = false
  upper   = false
}
