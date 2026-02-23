resource "aws_route53_record" "www_alias" {
  zone_id = var.zone_id
  name    = "www.${var.root_domain}"
  type    = "A"

  alias {
    name                   = var.cf_domain_name
    zone_id                = var.cf_hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_alias_ipv6" {
  zone_id = var.zone_id
  name    = "www.${var.root_domain}"
  type    = "AAAA"

  alias {
    name                   = var.cf_domain_name
    zone_id                = var.cf_hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "alias" {
  zone_id = var.zone_id
  name    = var.root_domain
  type    = "A"

  alias {
    name                   = var.cf_domain_name
    zone_id                = var.cf_hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "alias_ipv6" {
  zone_id = var.zone_id
  name    = var.root_domain
  type    = "AAAA"

  alias {
    name                   = var.cf_domain_name
    zone_id                = var.cf_hosted_zone_id
    evaluate_target_health = false
  }
}
