output "allow_http_lb" {
  value = aws_security_group.allow-http-lb.id
}

output "allow_http_lb_ec2" {
  value = aws_security_group.allow-http-lb-ec2.id
}
