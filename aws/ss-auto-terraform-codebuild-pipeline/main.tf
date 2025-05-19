
resource "aws_codepipeline" "resource" {
  name     = "${var.project}-${var.project_environment}-pipeline"
  role_arn = data.aws_ssm_parameter.pipelinerole.value
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
      role_arn =var.codecommit-role_arn!=""?var.codecommit-role_arn:data.aws_ssm_parameter.pipelinerole.value
      input_artifacts = []
      output_artifacts = ["source_output"]
      configuration = {
        RepositoryName = var.source_repository_name
        BranchName     = var.source_branch_name!=""?var.source_branch_name:var.project_environment
        OutputArtifactFormat: "CODE_ZIP"
      }
    }
  }


  stage {
    name = "Terraform-Plan"
    action {
      category = "Build"
      name     = "Terraform-Plan"
      owner    = "AWS"
      provider = "CodeBuild"
      version  = "1"
      input_artifacts = ["source_output"]
      output_artifacts = ["tf_plan_output"]
      configuration = {
        ProjectName = aws_codebuild_project.plan-resource.name
      }
    }
  }


  stage {
    name = "Manual-Approval"
    action {
      category = "Approval"
      name     = "Approve-Terraform-Apply"
      owner    = "AWS"
      provider = "Manual"
      version  = "1"
      input_artifacts = []
      output_artifacts = []
      configuration = {
        CustomData = "Review the Terraform plan before applying."
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
      input_artifacts = ["tf_plan_output"]
      output_artifacts = ["build_output"]
      configuration = {
       ProjectName=aws_codebuild_project.resource.name
      }
    }
  }
}