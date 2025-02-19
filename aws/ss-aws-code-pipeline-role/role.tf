resource "aws_iam_role" "pipeline" {
  name               = "${var.project}_pipline_role"
  assume_role_policy ="${file("../modules/ss-aws-code-pipeline/role.json")}"
  tags = {
    Name="${var.project}_pipline_role"
    Type="pipeline"
  }
}

resource "aws_iam_role_policy" "pipeline" {
  name = "${var.project}_pipeline_Policy"
  role = aws_iam_role.pipeline.id
  policy = "${file("../modules/ss-aws-code-pipeline/policy.json")}"
}