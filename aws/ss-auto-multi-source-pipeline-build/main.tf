data "aws_iam_role" "codepipeline" {
  name = var.role_name
}
data "aws_ssm_parameter" "kms-enc-id"{
  name=var.encrypt-id
}
variable "kms_key_enabled" {
  type = string
  default = "true"
}
variable "GitHubPersonalAccessToken" {
  type = string
  default = ""
}

variable "GitProvider" {
  type        = string
  description = "Choose the source provider for the pipeline"
  default     = "CodeCommit"
  validation {
    condition     = contains(["GitHub", "CodeCommit"], var.GitProvider)
    error_message = "SourceProvider must be GitHub or CodeCommit."
  }
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
    dynamic "encryption_key" {
      for_each = var.kms_key_enabled ? [1] : []
      content {
        id   = data.aws_ssm_parameter.kms-enc-id.value
        type = var.encrypt_type
      }
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
      role_arn =var.codecommit-role_arn!=""?var.codecommit-role_arn:data.aws_iam_role.codepipeline.arn
      input_artifacts = []
      output_artifacts = ["source_output"]
      configuration =var.GitProvider == "GitHub" ? {
        Owner      = split("/", var.source_repository_name)[0]
        Repo       = split("/", var.source_repository_name)[1]
        Branch     = var.source_branch_name!=""?var.source_branch_name:var.project_environment
        OAuthToken = var.GitHubPersonalAccessToken
      } : {
        RepositoryName = var.source_repository_name
        BranchName     = var.source_branch_name!=""?var.source_branch_name:var.project_environment
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