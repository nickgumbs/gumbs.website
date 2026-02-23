locals {
  bucket_name = var.bucket_name
}

module "s3" {
  source                        = "../../components/modules/s3"
  environment                   = var.environment
  bucket_name                   = local.bucket_name
  force_destroy                 = var.force_destroy
  cloudfront_distribution_arn   = module.cloudfront.cf_distribution_arn
}

module "cloudfront" {
  source                         = "../../components/modules/cloudfront"
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
  source      = "../../components/modules/acm"
  root_domain = var.root_domain
  zone_id     = data.aws_route53_zone.hosted_zone.id
}

module "route53" {
  source            = "../../components/modules/route53"
  zone_id           = data.aws_route53_zone.hosted_zone.id
  root_domain       = var.root_domain
  cf_domain_name    = module.cloudfront.cf_domain_name
  cf_hosted_zone_id = module.cloudfront.cf_hosted_zone_id
}

module "dynamodb" {
  source             = "../../components/modules/dynamodb"
  jokes_table_data   = var.ddb_jokes_table_data
  visitor_table_data = var.ddb_visitor_table_data
  environment        = var.environment
}

module "lambda" {
  source        = "../../components/modules/lambda"
  function_name = "gumbs-api-${var.environment}"
  source_dir    = "${path.root}/../../lambda"
  runtime       = "python3.12"
  environment   = var.environment
  environment_variables = {
    JOKES_TABLE    = module.dynamodb.jokes_table_name
    VISITORS_TABLE = module.dynamodb.visitor_table_name
  }
  dynamodb_table_arns = [
    module.dynamodb.jokes_table_arn,
    module.dynamodb.visitor_table_arn
  ]
}

module "apigateway" {
  source               = "../../components/modules/apigateway"
  api_name             = "gumbs-api-${var.environment}"
  environment          = var.environment
  lambda_invoke_arn    = module.lambda.invoke_arn
  lambda_function_name = module.lambda.function_name
}

resource "aws_s3_object" "app_config" {
  bucket       = module.s3.s3_bucket_id
  key          = "conf/config.json"
  content_type = "application/json"
  content = jsonencode({
    api = {
      base_url = module.apigateway.api_base_url
    }
  })
}

data "aws_route53_zone" "hosted_zone" {
  name = var.hosted_zone_name
}

