variable "opensearch" {
  type = object({
    security_options_enabled    = bool
    volume_type                 = string
    throughput                  = number
    ebs_enabled                 = bool
    ebs_volume_size             = number
    instance_type               = string
    instance_count              = number
    dedicated_master_enabled    = bool
    dedicated_master_count      = number
    dedicated_master_type       = string
    zone_awareness_enabled      = bool
    engine_version              = string
    snapshot_hour               =number
    service                     =string
    allow_public                =bool
  })
}

variable "domain_details" {type = object({
  domain=string
  hosted_zone=string
})}

variable "index_slow_logs_arn" {
  type    = string
}

variable "search_slow_logs_arn" {
  type    = string
}

variable "es_application_logs_arn" {
  type    = string
}
variable "account_id" {type = string}
variable "vpc_id" {type = string}
variable "subnet_ids" {type = list(string)}
variable "master_user" {type = string}
variable "master_password" {type = string}
variable "region_name" {type = string}
variable "vpc_cidr" {type=string}
