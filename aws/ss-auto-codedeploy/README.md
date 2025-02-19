# Terraform CodeDeploy Module

## Overview
This module sets up AWS CodeDeploy for deploying applications to EC2 instances.

## Source
The module source can be found at:
[Terraform Automation Module - CodeDeploy](https://github.com/sre-devops-ss/Terraform-automation-module/tree/main/aws/ss-auto-codedeploy)

## Required Variables
These variables must be provided when using the module:

- `project`: Defines the project name.
- `modifiedby`: Defines who modified the deployment.
- `project_environment`: Specifies the project environment (e.g., dev, prod).
- `ec2_tag_name`: Specifies the EC2 tag name for deployment.

## Optional Variables
These variables have default values but can be overridden:

- `codedeploy-role-name` (default: `common-codedeploy-role`)
- `platform` (default: `Server`)

## Usage
To use this module, define the required variables in your Terraform configuration and provide any optional overrides as necessary. Example:

```hcl
module "codedeploy" {
  source              = "git::https://github.com/sre-devops-ss/Terraform-automation-module.git//aws/ss-auto-codedeploy?ref=main"
  project             = "my-project"
  project_environment = "dev"
  modifiedby          = "admin"
  ec2_tag_name        = "my-ec2-instance"
}
```

Ensure you have the necessary IAM roles and permissions in place before deploying this module.

