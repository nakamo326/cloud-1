# TODO: valueへ変更する
locals {
  zone_name = "nakamo.dev"
}

data "aws_route53_zone" "zone" {
  name = local.zone_name
  private_zone = false
}

resource "aws_acm_certificate" "cert" {
  domain_name = local.zone_name
  validation_method = "DNS"
  subject_alternative_names = ["*.${local.zone_name}"]
  # albにアタッチされている時、ロックされるため
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.zone.id
}
