# TODO: valueへ変更する
locals {
  zone_name = "nakamo.dev"
}

data "aws_route53_zone" "zone" {
  name = local.zone_name
  private_zone = false
}