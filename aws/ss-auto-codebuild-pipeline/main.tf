data "aws_iam_role" "codepipeline" {
  name = var.role_name
}
data "aws_ssm_parameter" "kms-enc-id"{
  name=var.encrypt-id
}
data "aws_ssm_parameter" "pipeline-artifacts"{
  name=var.artifact-bucket
}

resource "aws_codepipeline" "resource" {
  depends_on = [data.aws_iam_role.codepipeline]
  name     = "${var.project}-${var.project_environment}-pipeline"
  role_arn = data.aws_iam_role.codepipeline.arn
  artifact_store {
    location = data.aws_ssm_parameter.pipeline-artifacts.value
    type     = var.artifact-type
    encryption_key {
      id   =data.aws_ssm_parameter.kms-enc-id.value
      type = var.encrypt_type
    }
  }

  stage {
    name = var.source_name
    action {
      category = var.source_category
      name     = var.source_name
      owner    = var.source_owner
      provider = var.source_provider
      version  = var.source_version
      role_arn =var.cross-role_arn!=""?var.cross-role_arn:data.aws_iam_role.codepipeline.arn
      input_artifacts = []
      output_artifacts = ["source_output"]
      configuration = {
        RepositoryName = var.source_repository_name
        BranchName     = var.source_branch_name
        OutputArtifactFormat: "CODE_ZIP"
      }
    }
  }
  stage {
    name = var.build_name
    action {
      category = var.build_category
      name     = var.build_name
      owner    = var.build_owner
      provider = var.build_provider
      version  = var.build_version
      input_artifacts = ["source_output"]
      output_artifacts = ["build_output"]
      configuration = {
       ProjectName=aws_codebuild_project.resource.name
      }
    }
  }
}