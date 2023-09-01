resource "aws_ecs_cluster" "v1cs-ecs-cluster" {
  name = "v1cs-ecs-cluster"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  tags = {
    Name = "v1cs-ecs-cluster"
  }
}

resource "aws_ecs_task_definition" "v1cs-ecs-task-apache" {
  family                   = "service"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 512
  memory                   = 2048
  tags = {
    Name = "v1cs-ecs-task-apache"
  }
  container_definitions    = <<DEFINITION
  [
    {
      "name"      : "apache-app",
      "image"     : "jrrdev/cve-2017-5638",
      "cpu"       : 512,
      "memory"    : 2048,
      "essential" : true,
      "portMappings" : [
        {
          "containerPort" : 8080,
          "hostPort"      : 8080
        }
      ]
    }
  ]
  DEFINITION
}

resource "aws_ecs_task_definition" "v1cs-ecs-task-shell" {
  family                   = "service"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 512
  memory                   = 2048
  tags = {
    Name = "v1cs-ecs-task-shell"
  }
  container_definitions    = <<DEFINITION
  [
    {
      "name"      : "shell-app",
      "image"     : "hmlio/vaas-cve-2014-6271",
      "cpu"       : 512,
      "memory"    : 2048,
      "essential" : true,
      "portMappings" : [
        {
          "containerPort" : 80,
          "hostPort"      : 80
        }
      ]
    }
  ]
  DEFINITION
}

resource "aws_ecs_service" "v1cs-ecs-service-apache" {
  name             = "apache-service"
  cluster          = aws_ecs_cluster.v1cs-ecs-cluster.id
  task_definition  = aws_ecs_task_definition.v1cs-ecs-task-apache.id
  desired_count    = 1
  launch_type      = "FARGATE"
  platform_version = "LATEST"
  tags = {
    Name = "v1cs-ecs-service-apache"
  }

  network_configuration {
    assign_public_ip = true
    security_groups  = [aws_security_group.v1cs-ecs-sg-apache.id]
    subnets          = [aws_subnet.v1cs-ecs-subnet.id]
  }
  lifecycle {
    ignore_changes = [task_definition]
  }
}

resource "aws_ecs_service" "v1cs-ecs-service-shell" {
  name             = "shell-service"
  cluster          = aws_ecs_cluster.v1cs-ecs-cluster.id
  task_definition  = aws_ecs_task_definition.v1cs-ecs-task-shell.id
  desired_count    = 1
  launch_type      = "FARGATE"
  platform_version = "LATEST"
  tags = {
    Name = "v1cs-ecs-service-shell"
  }

  network_configuration {
    assign_public_ip = true
    security_groups  = [aws_security_group.v1cs-ecs-sg-shell.id]
    subnets          = [aws_subnet.v1cs-ecs-subnet.id]
  }
  lifecycle {
    ignore_changes = [task_definition]
  }
}