resource "aws_eip" "nat-gateway-eip-1" {
  domain = "vpc"
  tags = {
    Name = "${var.project}-nat-gateway-eip-1"
  }
}

resource "aws_eip" "nat-gateway-eip-2" {
  domain = "vpc"
  tags = {
    Name = "${var.project}-nat-gateway-eip-2"
  }
}
