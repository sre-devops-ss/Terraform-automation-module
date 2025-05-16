variable "role_name-param-store" {
  type = string
  default = "/common/codepipeline/role"
}
variable "codebuild-role-param-store" {
  type = string
  default = "/common/codebuild/role"
}

variable "codedeploy-role-param-store" {
  type = string
  default = "/common/codedeploy/role"
}
data "aws_ssm_parameter" "codedeployrole"{
  name=var.codebuild-role-param-store
}
data "aws_ssm_parameter" "pipelinerole"{
  name=var.role_name-param-store
}
data "aws_ssm_parameter" "codebuildrole"{
  name=var.codebuild-role-param-store
}

variable "project" {type =string}
variable "modifiedby" {type = string}
variable "project_environment" {type=string}


variable "source_type" {
  type    = string
  default = "CODEPIPELINE"
}


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
variable "retention" { type = number
default = 3}


variable "codebuild-role-name" {
  type = string
  default = "common-codebuild-role"
}
variable "buildspec-value" {
  type = string
}