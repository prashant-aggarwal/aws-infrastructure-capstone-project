resource "aws_security_group" "allow-http-lb" {
  name        = "${var.project}-allow-http-lb"
  description = "Allow HTTP Traffic for ALB"
  vpc_id      = var.vpc_id
  
  tags = {
    Name = "${var.project}-allow-http-lb"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow-http-lb-ingress" {
  security_group_id = aws_security_group.allow-http-lb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow-http-lb-egress" {
  security_group_id = aws_security_group.allow-http-lb.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_security_group" "allow-http-lb-ec2" {
  name        = "${var.project}-allow-http-lb-ec2"
  description = "Allow HTTP Traffic from ALB to EC2 instances"
  vpc_id      = var.vpc_id
  
  tags = {
    Name = "${var.project}-allow-http-lb-ec2"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow-http-lb-ec2-ingress" {
  security_group_id = aws_security_group.allow-http-lb-ec2.id
  referenced_security_group_id = aws_security_group.allow-http-lb.id
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow-http-lb-ec2-egress" {
  security_group_id = aws_security_group.allow-http-lb-ec2.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
