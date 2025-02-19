# Terraform CodeBuild V2 Module

## Overview
This module sets up an AWS CodeBuild environment with configurable settings for compute, environment variables, and source type.

## Source
The module source can be found at:
[Terraform Automation Module - CodeBuild V2](https://github.com/sre-devops-ss/Terraform-automation-module/tree/main/aws/ss-auto-codebuild-v2)

## Required Variables
These variables must be provided when using the module:

- `project`: Defines the project name.
- `modifiedby`: Defines who modified the deployment.
- `project_environment`: Specifies the project environment (e.g., dev, prod).

## Optional Variables
These variables have default values but can be overridden:

### CodeBuild Settings
- `source_type` (default: `CODEPIPELINE`)
- `env_compute_type` (default: `BUILD_GENERAL1_SMALL`)
- `env_image` (default: `aws/codebuild/amazonlinux2-x86_64-standard:3.0`)
- `env_type` (default: `LINUX_CONTAINER`)
- `env_vars` (default: `[{ name="isTerraform", value="true" }]`)
- `retention` (default: `3`)
- `buildspec-parameter` (default: `/common/codebuild/base`)
- `codebuild-role-name` (default: `common-codebuild-role`)

## Usage
To use this module, define the required variables in your Terraform configuration and provide any optional overrides as necessary. Example:

```hcl
module "codebuild" {
  source               = "git::https://github.com/sre-devops-ss/Terraform-automation-module.git//aws/ss-auto-codebuild-v2?ref=main"
  project             = "my-project"
  project_environment = "dev"
  modifiedby          = "admin"
}
```

Ensure you have the necessary IAM roles and permissions in place before deploying this module.

