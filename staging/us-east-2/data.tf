data "aws_route53_zone" "ngassamlabs" {
  name = "ngassamlabs.com."
}
  
  data "aws_acm_certificate" "alb_cert" {
  domain      = "www.ngassamlabs.com"
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}