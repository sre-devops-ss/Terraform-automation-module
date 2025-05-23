resource "aws_codestarconnections_connection" "codestar_connection_git" {
  count= var.source_provider=="CodeStarSourceConnection"? 1:0
  name          = "${var.project}-${var.project_environment}-codestar"
  provider_type = var.source_provider
}
resource "aws_codepipeline" "resource" {
  name     = "${var.project}-${var.project_environment}-pipeline"
  role_arn = data.aws_ssm_parameter.pipelinerole.value
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
      role_arn =var.codecommit-role_arn!=""?var.codecommit-role_arn:data.aws_ssm_parameter.pipelinerole.value
      input_artifacts = []
      output_artifacts = ["source_output"]
      configuration =var.source_provider != "CodeCommit" ? {
        #v1-----
        # Owner      = split("/", var.source_repository_name)[0]
        # Repo       = split("/", var.source_repository_name)[1]
        # Branch     = var.source_branch_name!=""?var.source_branch_name:var.project_environment
        # OAuthToken = var.GitHubPersonalAccessToken

        #v2
        #------
        ConnectionArn=aws_codestarconnections_connection.codestar_connection_git.arn
        FullRepositoryId=var.source_repository_name
        BranchName=var.source_branch_name!=""?var.source_branch_name:var.project_environment
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