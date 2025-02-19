variable "pipeline" {
    type=object({
      stage=list(object({
        name             = string
        category         = string
        owner            = string
        provider         = string
        version          = string
        cross_acc_arn=string
        input_artifacts  = list(string)
        output_artifacts = list(string)
        configuration    =map(string)
      }))
      artifact=object({
        type=string
        bucket=string
        encrypt=object({
          id=string
          type=string
        })
      })
    })
}

variable "project" {type = string}

variable "role_name" {type = string}
variable "modifiedby" {type = string}
variable "project_environment" {type=string}
