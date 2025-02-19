resource "aws_iam_role" "codedeploy" {
  name = "${var.project}_${var.project_environment}-codedeploy-role"
  assume_role_policy ="${file("../../../modules/ss-aws-code-codedeploy/role.json")}"
}

resource "aws_iam_role_policy" "codedeploy_policy" {
  name = "${var.project}_${var.project_environment}-codedeploy-policy"
  role = aws_iam_role.codedeploy.id
  policy = "${file("../../../modules/ss-aws-code-codedeploy/policy.json")}"
}
