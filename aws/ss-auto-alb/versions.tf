terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      # version = ">= 5.82"
      version = "= 5.79"
    }
  }
}
