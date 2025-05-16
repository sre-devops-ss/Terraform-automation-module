data "aws_iam_role" "codepipeline" {
  name = var.role_name
}
data "aws_iam_role" "codebuild"{
  name = var.codebuild-role-name
}

variable "role_name-param-store" {
  type = string
  default = "/common/codepipeline/role"
}
variable "codebuild-role-param-store" {
  type = string
  default = "/common/codebuild/role"
}
data "aws_ssm_parameter" "pipelinerole"{
  name=var.role_name-param-store
}
data "aws_ssm_parameter" "codebuildrole"{
  name=var.codebuild-role-param-store
}
data "aws_ssm_parameter" "pipeline-artifacts"{
  name=var.artifact-bucket
}
data "aws_ssm_parameter" "kms-enc-id"{
  name=var.encrypt-id
}


data "aws_ssm_parameter" "buildspec"{
  name="/common/codebuild/base"
}

#--------------

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
  default = "Apply"
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

variable "role_name" {
  type = string
  default = "common-codepipeline-role"
}






variable "codecommit-role_arn" {
  type = string
  default = ""
}

variable "buildspec-value" {
  type = string
  default = ""
}
variable "modifiedby" {
  type = string
}
variable "project_environment" {
  type=string
}
variable "project" {
  type = string
}

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
  default = ""
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
variable "plan-buildspec-parameter" {
  type = string
  default = "/common/codebuild/base"
}
