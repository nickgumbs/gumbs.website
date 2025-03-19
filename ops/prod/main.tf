locals {
  bucket_name = "${var.bucket_name}-${random_string.random_id[0].id}"
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

module "s3" {
  source              = "../components/modules/s3"
  environment         = var.environment
  bucket_name         = local.bucket_name
  root_domain         = var.root_domain
  dist_filepath       = var.dist_filepath
  cf_distribution_arn = module.cloudfront.cf_distribution_arn
}

module "cloudfront" {
  source                         = "../components/modules/cloudfront"
  bucket_name                    = local.bucket_name
  root_domain                    = var.root_domain
  cache_policy_name              = var.cache_policy_name
  index_page                     = var.index_page
  environment                    = var.environment
  s3_bucket_id                   = module.s3.s3_bucket_id
  s3_bucket_regional_domain_name = module.s3.s3_bucket_regional_domain_name
  acm_certificate_arn            = module.acm.acm_certificate_arn

}

module "acm" {
  source      = "../components/modules/acm"
  root_domain = var.root_domain
  zone_id     = data.aws_route53_zone.hosted_zone.id
}

module "route53" {
  source            = "../components/modules/route53"
  zone_id           = data.aws_route53_zone.hosted_zone.id
  root_domain       = var.root_domain
  cf_domain_name    = module.cloudfront.cf_domain_name
  cf_hosted_zone_id = module.cloudfront.cf_hosted_zone_id
}

module "dynamodb" {
  source             = "../components/modules/dynamodb"
  jokes_table_data   = var.ddb_jokes_table_data
  visitor_table_data = var.ddb_visitor_table_data
  environment        = var.environment
}

data "aws_route53_zone" "hosted_zone" {
  name = var.hosted_zone_name
}

resource "random_string" "random_id" {
  length  = 16
  count   = 1
  special = false
  upper   = false
}
