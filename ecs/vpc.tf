resource "aws_vpc" "v1cs-ecs-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    name = "v1cs-ecs-vpc"
  }
}

resource "aws_subnet" "v1cs-ecs-subnet" {
  vpc_id                  = aws_vpc.v1cs-ecs-vpc.id
  cidr_block              = cidrsubnet(aws_vpc.v1cs-ecs-vpc.cidr_block, 8, 1) ## takes 10.0.0.0/16 --> 10.0.1.0/24
  map_public_ip_on_launch = true
  availability_zone       = "${var.region}a"
}

resource "aws_internet_gateway" "v1cs-ecs-igw" {
  vpc_id = aws_vpc.v1cs-ecs-vpc.id

  tags = {
    Name = "v1cs-ecs-igw"
  }
}

resource "aws_route_table" "v1cs-ecs-rt" {
  vpc_id = aws_vpc.v1cs-ecs-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.v1cs-ecs-igw.id
  }
}

resource "aws_route_table_association" "v1cs-ecs-subnet_route" {
  subnet_id      = aws_subnet.v1cs-ecs-subnet.id
  route_table_id = aws_route_table.v1cs-ecs-rt.id
}