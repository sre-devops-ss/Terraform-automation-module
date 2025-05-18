resource "aws_cloudwatch_log_group" "plan-build" {
  name = "codebuild/${var.project}-plan-${var.project_environment}"
  retention_in_days = var.retention
  tags = {

    Application = "codebuild/${var.project}-plan-${var.project_environment}"
  }
}
resource "aws_cloudwatch_log_stream" "plan-build" {
  depends_on = [aws_cloudwatch_log_group.plan-build]
  log_group_name = aws_cloudwatch_log_group.plan-build.name
  name           = "${var.project}-plan-build-${var.project_environment}"
}

resource "aws_codebuild_project" "plan-resource" {

  name         = "${var.project}-plan-build-${var.project_environment}"
  service_role = data.aws_ssm_parameter.codebuildrole.value

  artifacts {
    type = var.source_type
  }

  source {
    type =var.source_type
    buildspec =var.plan-buildspec-value!=""?var.plan-buildspec-value:data.aws_ssm_parameter.plan-buildspec.value
    report_build_status = true
  }

  environment {
    compute_type    = var.env_compute_type
    image           = var.env_image
    type            = var.env_type
    privileged_mode = true

    dynamic "environment_variable"{
      for_each =var.env_vars
      content {
        name=environment_variable.value.name
        value=environment_variable.value.value
      }
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = aws_cloudwatch_log_group.plan-build.name
      stream_name = aws_cloudwatch_log_stream.plan-build.name
    }
  }

  tags = {
    Name="${var.project}-plan-build"
    last_tf_change=var.modifiedby
    env="codebuild/${var.project}-plan-${var.project_environme