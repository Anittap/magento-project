data "aws_route53_zone" "main" {
  name         = var.domain_name
  private_zone = false
}
data "aws_acm_certificate" "issued" {
  domain   = var.domain_name
  statuses = ["ISSUED"]
}
