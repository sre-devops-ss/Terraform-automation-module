terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      # version = ">= 5.61.0"
      # version = "= 5.79"
      version = ">=5.0"
    }
  }
}