output "name" {
  value = aws_codepipeline.resource.name
}
output "codebuild-name" {
  value = aws_codebuild_project.resource.name
}
output "codedeploy-app-name" {
  value = aws_codedeploy_app.resource.name
}
output "codedeploy-group" {
  value = aws_codedeploy_deployment_group.resource.deployment_group_name
}