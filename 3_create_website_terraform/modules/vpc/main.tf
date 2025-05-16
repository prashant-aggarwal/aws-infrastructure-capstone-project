resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name    = "${var.project}-vpc"
    Project = var.project
  }
}

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project}-vpc-ig"
  }
}

resource "aws_default_route_table" "rt" {
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }
  default_route_table_id = aws_vpc.vpc.default_route_table_id
}
