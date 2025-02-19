resource "aws_cloudwatch_log_resource_policy" "resource" {
  policy_name     = "${var.opensearch.service}-es-policy"
  policy_document = data.aws_iam_policy_document.log.json
}
#resource "aws_opensearch_domain_policy" "main" {
#  domain_name     = aws_opensearch_domain.opensearch.domain_name
#  access_policies = data.aws_iam_policy_document.main.json
#}