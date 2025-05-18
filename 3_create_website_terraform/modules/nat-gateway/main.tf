resource "aws_nat_gateway" "nat-gateway-subnet-a" {
  allocation_id = var.nat_gateway_eip_1_id
  subnet_id     = var.subnet_a_id

  tags = {
    Name = "${var.project}-nat-gateway-subnet-a"
  }
}

resource "aws_nat_gateway" "nat-gateway-subnet-b" {
  allocation_id = var.nat_gateway_eip_2_id
  subnet_id     = var.subnet_b_id

  tags = {
    Name = "${var.project}-nat-gateway-subnet-b"
  }
}
