terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }
}
resource "random_id" "decimal" {
  keepers = {
    first = "${timestamp()}"
  }
  byte_length = 8
}

resource "aws_cloudwatch_log_group" "build" {
  depends_on = [random_id.decimal]
  name = "aws/codebuild/"
  retention_in_days = var.retention
  tags = {

    Application = "${var.project}-${random_id.decimal.dec}"
  }
}
resource "aws_cloudwatch_log_stream" "build" {
  depends_on = [aws_cloudwatch_log_group.build]
  log_group_name = aws_cloudwatch_log_group.build.name
  name           = "${var.project}-build-${var.project_environment}"
}

resource "aws_codebuild_project" "resource" {

  name         = "${var.project}-build-${var.project_environment}"
  service_role = aws_iam_role.codebuild.arn

  artifacts {
    type = var.source_type
  }

  source {
    type =var.source_type
    buildspec =var.buildspec
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