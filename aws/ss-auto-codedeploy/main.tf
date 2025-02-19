resource "aws_codedeploy_app" "resource" {
  compute_platform =var.platform
  name             = "${var.project}-build-${var.project_environment}-application"
}