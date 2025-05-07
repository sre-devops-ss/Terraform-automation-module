output "name" {
  value = aws_codepipeline.resource.name
}
output "codebuild-name" {
  value = aws_codebuild_project.resource.name
}