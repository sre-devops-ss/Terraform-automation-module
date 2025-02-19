resource "aws_iam_role" "codebuild" {
  name               = "${var.project}_${var.project_environment}_codebuild_role"
  assume_role_policy ="${file("../../../modules/ss-aws-code-codebuild/role.json")}"
  tags = {
    Name="${var.project}_codebuild_role"
    Type="codebuild"
  }
}
resource "aws_iam_role_policy" "codebuild" {
  name = "${var.project}_${var.project_environment}_codebuild_Policy"
  role = aws_iam_role.codebuild.id
  policy = "${file("../../../modules/ss-aws-code-codebuild/policy.json")}"
}