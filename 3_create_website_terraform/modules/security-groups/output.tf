output "sg_allow_http_lb_id" {
  value = aws_security_group.allow-http-lb.id
}

output "sg_allow_http_lb_ec2_id" {
  value = aws_security_group.allow-http-lb-ec2.id
}
