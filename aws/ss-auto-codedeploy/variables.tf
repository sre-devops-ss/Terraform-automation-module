

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