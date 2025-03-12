variable "source_type" {
  type    = string
  default = "CODEPIPELINE"
}
# Source Stage Variables
variable "source_name" {
  type    = string
  default = "Source"
}

variable "source_category" {
  type    = string
  default = "Source"
}

variable "source_owner" {
  type    = string
  default = "AWS"
}


variable "source_provider" {
  type    = string
  default = "CodeCommit"
}

variable "source_version" {
  type    = string
  default = "1"
}


# Build Stage Variables
variable "build_name" {
  type    = string
  default = "Build"
}

variable "build_category" {
  type    = string
  default = "Build"
}

variable "build_owner" {
  type    = string
  default = "AWS"
}

variable "build_provider" {
  type    = string
  default = "CodeBuild"
}

variable "build_version" {
  type    = string
  default = "1"
}

variable "deploy_version" {
  type    = string
  default = "1"
}

variable "deploy_owner" {
  type    = string
  default = "AWS"
}

variable "deploy_provider" {
  type    = string
  default = "CodeDeploy"
}
variable "deploy_name" {
  type    = string
  default = "Deploy"
}
variable "deploy_category" {
  type    = string
  default = "Deploy"
}






#codebuild
#---------


variable "env_compute_type" {
  type    = string
  default = "BUILD_GENERAL1_SMALL"
}

variable "env_image" {
  type    = string
  default = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
}

variable "env_type" {
  type    = string
  default = "LINUX_CONTAINER"
}

variable "env_vars" {
  type = list(object({
    name=string
    value=string
  }))
  default = [
    {
      name="isTerraform"
      value="true"
    }]
}
variable "retention" {
  type = number
  default = 3
}

variable "codebuild-role-name" {
  type = string
  default = "common-codebuild-role"
}
# ----------------------


#CodeDeploy
#-----------
variable "platform" {
  type = string
  default = "Server"
}
variable "codedeploy-role-name" {
  type = string
  default = "common-codedeploy-role"
}



variable "role_name" {
  type = string
  default = "common-codepipeline-role"
}

variable "cross-role_arn" {
  type = string
  default = ""
}

variable "buildspec-parameter" {
  type = string
  default = "/common/codebuild/base"
}
variable "ec2_tag_name" {type = string} #Deployment
variable "modifiedby" {type = string}
variable "project_environment" {type=string}
variable "project" {type = string}

variable "encrypt-id" {
  type = string
  default = "/common/pipeline/kms-encrypt-id"
}
variable "artifact-bucket" {
  type = string
  default = "/common/pipeline/artifcats"

}
variable "source_repository_name" {
  type    = string
}
variable "source_branch_name" {
  type    = string
}

#pipeline

variable "encrypt_type" {
  type = string
  default = "KMS"
}
variable "artifact-type" {
  type = string
  default = "S3"
}
