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

variable "codedeploy-role-name" {
  type = string
  default = "common-codedeploy-role"
}
variable "platform" {type = string
default = "Server"}
variable "ec2_tag_name" {type = string}