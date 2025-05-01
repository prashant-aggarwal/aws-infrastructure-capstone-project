output "load_balancer_address" {
  value = aws_lb.alb.dns_name
}

output "load_balancer_id" {
  value = aws_lb.alb.id
}

