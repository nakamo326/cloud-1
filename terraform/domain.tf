# TODO: valueへ変更する
locals {
  zone_name = "nakamo.dev"
}

# TODO: zoneはdataにする
resource "aws_route53_zone" "main" {
  name = local.zone_name
}