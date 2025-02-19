#data "aws_iam_policy_document" "main" {
#  effect = "Allow"
#
#  principals {
#    type        = "*"
#    identifiers = ["*"]
#  }
#
#  actions   = ["es:*"]
#  resources = ["${aws_opensearch_domain.opensearch.arn}/*"]
#
#  condition {
#    test     = "IpAddress"
#    variable = "aws:SourceIp"
#    values   = var.opensearch.allow_public?"0.0.0.0/0":var.vpc_cidr
#  }
#}