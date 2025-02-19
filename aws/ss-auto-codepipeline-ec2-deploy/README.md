# Terraform Pipeline Module

## Overview
This module sets up an AWS CodePipeline with CodeBuild and CodeDeploy stages. It uses various configurable variables to define the pipeline stages, environments, and dependencies.

## Source
The module source can be found at:
[Terraform Automation Module - CodePipeline EC2 Deploy](https://github.com/sre-devops-ss/Terraform-automation-module/tree/main/aws/ss-auto-codepipeline-ec2-deploy)

## Required Variables
These variables must be provided when using the module:

- `ec2_tag_name`: Specifies the EC2 tag for deployment.
- `modifiedby`: Defines who modified the deployment.
- `project_environment`: Specifies the project environment (e.g., dev, prod).
- `project`: Defines the project name.
- `encrypt-id`: The ID of the encryption key.
- `artifact-bucket`: The S3 bucket for storing artifacts.
- `source_repository_name`: The name of the source repository.
- `source_branch_name`: The branch to be used from the repository.

## Optional Variables
These variables have default values but can be overridden:

### Source Stage
- `source_name` (default: `Source`)
- `source_category` (default: `Source`)
- `source_owner` (default: `AWS`)
- `source_provider` (default: `CodeCommit`)
- `source_version` (default: `1`)

### Build Stage
- `build_name` (default: `Build`)
- `build_category` (default: `Build`)
- `build_owner` (default: `AWS`)
- `build_provider` (default: `CodeBuild`)
- `build_version` (default: `1`)

### Deploy Stage
- `deploy_name` (default: `Deploy`)
- `deploy_category` (default: `Deploy`)
- `deploy_owner` (default: `AWS`)
- `deploy_provider` (default: `CodeDeploy`)
- `deploy_version` (default: `1`)

### CodeBuild Settings
- `source_type` (default: `CODEPIPELINE`)
- `env_compute_type` (default: `BUILD_GENERAL1_SMALL`)
- `env_image` (default: `aws/codebuild/amazonlinux2-x86_64-standard:3.0`)
- `env_type` (default: `LINUX_CONTAINER`)
- `env_vars` (default: `[{ name="isTerraform", value="true" }]`)
- `retention` (default: `3`)
- `codebuild-role-name` (default: `common-codebuild-role`)

### CodeDeploy Settings
- `platform` (default: `Server`)
- `codedeploy-role-name` (default: `common-codedeploy-role`)

### General Pipeline Settings
- `role_name` (default: `common-codepipeline-role`)
- `cross-role_arn` (default: `""`)
- `buildspec-parameter` (default: `/common/codebuild/base`)
- `encrypt_type` (default: `KMS`)
- `artifact-type` (default: `S3`)

## Usage
To use this module, define the required variables in your Terraform configuration and provide any optional overrides as necessary. Example:

```hcl
module "pipeline" {
  source                 = "git::https://github.com/sre-devops-ss/Terraform-automation-module.git//aws/ss-auto-codepipeline-ec2-deploy?ref=main"
  project               = "my-project"
  project_environment   = "dev"
  ec2_tag_name          = "my-ec2-tag"
  modifiedby            = var.modifiedby
  encrypt-id            = var.encrypt-id
  artifact-bucket       = "${var.artifact-bucket}-${var.environment}"
  source_repository_name = "my-repo"
  source_branch_name     = "main"
}
```

Ensure you have the necessary IAM roles and permissions in place before deploying this module.

