output "app_name" {
  value = aws_codedeploy_app.resource.name
}
output "group_name" {
  value = aws_codedeploy_deployment_group.resource.deployment_group_name
}