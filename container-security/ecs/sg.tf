resource "aws_security_group" "v1cs-ecs-sg-apache" {
  name   = "v1cs-ecs-sg-apache"
  vpc_id = aws_vpc.v1cs-ecs-vpc.id
  tags = {
    Name = "v1cs-ecs-sg-apache"
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    self        = "false"
    cidr_blocks = ["0.0.0.0/0"]
    description = "http"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "v1cs-ecs-sg-shell" {
  name   = "v1cs-ecs-sg-shell"
  vpc_id = aws_vpc.v1cs-ecs-vpc.id
  tags = {
    Name = "v1cs-ecs-sg-shell"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    self        = "false"
    cidr_blocks = ["0.0.0.0/0"]
    description = "http"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}