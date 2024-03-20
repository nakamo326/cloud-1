resource "aws_route53_record" "www" {
  name    = "www.${local.zone_name}"
  type    = "A"
  zone_id = data.aws_route53_zone.zone.id

  alias {
    name                   = aws_alb.alb.dns_name
    zone_id                = aws_alb.alb.zone_id
    evaluate_target_health = true
  }
}
