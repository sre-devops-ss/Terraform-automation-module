data "aws_route53_zone" "opensearch" {
  name = var.domain_details.hosted_zone
}
data "aws_acm_certificate" "opensearch" {
  domain = var.domain_details.domain
}



