resource "aws_route_table" "public-rt" {
  vpc_id = var.vpc_id
  
  route {
    cidr_block = var.vpc_cidr
    nat_gateway_id = var.nat_gateway_subnet_a_id
  }

  route {
    cidr_block = var.vpc_cidr
    nat_gateway_id = var.nat_gateway_subnet_b_id
  }
  
  tags = {
    Name = "${var.project}-public-rt"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = var.subnet_a_id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = var.subnet_b_id
  route_table_id = aws_route_table.public-rt.id
}