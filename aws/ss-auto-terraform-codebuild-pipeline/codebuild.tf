resource "aws_cloudwatch_log_group" "build" {
  name = "codebuild/${var.project}-${var.project_environment}"
  retention_in_days = var.retention
  tags = {

    Application = "codebuild/${var.project}-${var.project_environment}"
  }
}
resource "aws_cloudwatch_log_stream" "build" {
  depends_on = [aws_cloudwatch_log_group.build]
  log_group_name = aws_cloudwatch_log_group.build.name
  name           = "${var.project}-build-${var.project_environment}"
}

resource "aws_codebuild_project" "resource" {

  name         = "${var.project}-build-${var.project_environment}"
  service_role = data.aws_ssm_parameter.codebuildrole.value

  artifacts {
    type = var.source_type
  }

  source {
    type =var.source_type
    buildspec =var.apply-buildspec-value!=""?var.apply-buildspec-value:data.aws_ssm_parameter.apply-buildspec.value
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
      group_name  = aws_cloudwatch_log_group.build.name
      stream_name = aws_cloudwatch_log_stream.build.name
    }
  }

  tags = {
    Name="${var.project}-build"
    last_tf_change=var.modifiedby
    env=var.project_environment
  }

}