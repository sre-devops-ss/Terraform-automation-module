
resource "aws_codedeploy_deployment_group" "resource" {
  depends_on = [aws_iam_role.codedeploy]
  app_name              = aws_codedeploy_app.resource.name
  deployment_group_name = "${var.project}-build-${var.project_environment}-deploy-group"
  service_role_arn      = aws_iam_role.codedeploy.arn

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      type  = "KEY_AND_VALUE"
      value = var.ec2_tag_name
    }
  }
  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }
}