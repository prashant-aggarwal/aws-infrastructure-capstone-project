resource "aws_route_table" "private-rt-subnet-c" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_subnet_a_id
  }

  tags = {
    Name = "${var.project}-private-rt-subnet-c"
  }
}

resource "aws_route_table_association" "private_rt_subnet_c_association" {
  subnet_id      = var.subnet_c_id
  route_table_id = aws_route_table.private-rt-subnet-c.id
}

resource "aws_route_table" "private-rt-subnet-d" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_subnet_b_id
  }

  tags = {
    Name = "${var.project}-private-rt-subnet-d"
  }
}

resource "aws_route_table_association" "private_rt_subnet_c_association_d" {
  subnet_id      = var.subnet_d_id
  route_table_id = aws_route_table.private-rt-subnet-d.id
}
