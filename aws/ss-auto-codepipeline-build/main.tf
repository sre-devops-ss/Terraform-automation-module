resource "aws_codepipeline" "resource" {
  name     = "$${var.project}-${var.project_environment}-pipeline"
  role_arn = data.aws_iam_role.details.arn
  artifact_store {
    location = var.pipeline.artifact.bucket
    type     = var.pipeline.artifact.type
    encryption_key {
      id   =var.pipeline.artifact.encrypt.id
      type = var.pipeline.artifact.encrypt.type
    }
  }

  dynamic "stage" {
    for_each =var.pipeline.stage
    content {
      name =stage.value.name
      action {
        category = stage.value.category
        name     = stage.value.name
        owner    = stage.value.owner
        provider = stage.value.provider
        version  = stage.value.version
        output_artifacts =stage.value.output_artifacts
        input_artifacts = stage.value.input_artifacts
        role_arn = stage.value.cross_acc_arn
        configuration = stage.value.configuration
      }

    }
  }



}