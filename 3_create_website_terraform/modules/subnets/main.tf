resource "aws_subnet" "subnet-a" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.subnet_a_cidr
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = var.add_public_ip

  tags = {
    Name = "${var.project}-vpc-subnet-a"
  }
}

resource "aws_subnet" "subnet-b" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.subnet_b_cidr
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = var.add_public_ip

  tags = {
    Name = "${var.project}-vpc-subnet-b"
  }
}

