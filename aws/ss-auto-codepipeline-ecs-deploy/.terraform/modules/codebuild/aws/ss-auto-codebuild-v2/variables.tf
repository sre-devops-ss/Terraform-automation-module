variable "project" {type =string}
variable "modifiedby" {type = string}
variable "project_environment" {type=string}
variable "log_group" {type = string}
variable "log_stream" {type = string}

variable "buildspec" {
  type    = string
  default = "buildspec.yml"
}

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
