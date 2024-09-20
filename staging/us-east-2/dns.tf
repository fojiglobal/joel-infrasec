# resource "aws_route53_record" "staging" {
#  zone_id = data.aws_route53_zone.ngassamlabs.zone_id
#  name    = "www.${data.aws_route53_zone.ngassamlabs.name}"
#  type    = "A"
#  ttl     = "300"
#  records = ["10.0.0.1"]
# }

resource "aws_route53_record" "staging" {
  zone_id = data.aws_route53_zone.ngassamlabs.zone_id
  name    = "staging.ngassamlabs.com"
  type    = "A"

  alias {
    name                   = aws_lb.staging_alb.dns_name
    zone_id                = aws_lb.staging_alb.zone_id
    evaluate_target_health = true
  }
}