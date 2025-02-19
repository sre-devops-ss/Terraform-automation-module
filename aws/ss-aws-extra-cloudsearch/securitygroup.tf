resource "aws_security_group" "opensearch_security_group" {
  name        = "${var.opensearch.service}-sg"
  vpc_id      = var.vpc_id
  description = "Allow inbound HTTP traffic"

  ingress {
    description = "HTTP from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"

    cidr_blocks =var.opensearch.allow_public? ["0.0.0.0/0"]:[var.vpc_cidr]
  }
}