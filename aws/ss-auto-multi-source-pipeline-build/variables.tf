variable "buildspec-value" {
  type = string
  default = ""
}
data "aws_ssm_parameter" "buildspec"{
  name="/common/codebuild/base"
}

variable "apply-buildspec-value" {
  type = string
  default = ""
}
data "aws_ssm_parameter" "apply-buildspec"{
  name="/terraform/apply/codebuild/base"
}


variable "plan-buildspec-value" {
  type = string
  default = ""
}
data "aws_ssm_parameter" "plan-buildspec"{
  name="/terraform/plan/codebuild/base"
}


variable "role_name-param-store" {
  type = string
  default = "/common/codepipeline/role"
}
data "aws_ssm_parameter" "pipelinerole"{
  name=var.role_name-param-store
}


variable "codebuild-role-param-store" {
  type = string
  default = "/common/codebuild/role"
}
data "aws_ssm_parameter" "codebuildrole"{
  name=var.codebuild-role-param-store
}

variable "kms_key_enabled" {
  type = string
  default = "true"
}
variable "GitHubPersonalAccessToken" {
  type = string
  default = ""
}




variable "codedeploy-role-param-store" {
  type = string
  default = "/common/codedeploy/role"
}
data "aws_ssm_parameter" "codedeployrole"{
  name=var.codedeploy-role-param-store
}


variable "encrypt-id" {
  type = string
  default = "/common/pipeline/kms-encrypt-id"
}
data "aws_ssm_parameter" "kms-enc-id"{
  name=var.encrypt-id
}
variable "artifact-bucket" {
  type = string
  default = "/common/pipeline/artifcats"
}
data "aws_ssm_parameter" "pipeline-artifacts"{
  name=var.artifact-bucket
}


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


# ----------------------


#CodeDeploy
#-----------
variable "platform" {
  type = string
  default = "Server"
}

variable "codecommit-role_arn" {
  type = string
  default = ""
}
variable "ec2_tag_name" {
  type = string
  default = ""
} #Deployment
variable "modifiedby" {
  type = string
}
variable "project_environment" {
  type=string
}
variable "project" {
  type = string
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


variable "ecs-cluster-name" {
  type = string
  default = ""
}
variable "ecs-service-name" {
  type = string
  default = ""
}