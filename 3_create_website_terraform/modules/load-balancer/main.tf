resource "aws_lb" "alb" {
  name               = "${var.project}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_allow_http_lb_id]
  subnets            = [var.subnet_a_id, var.subnet_b_id]

  tags = {
    Name    = "${var.project}-alb"
    Project = var.project
  }
}

resource "aws_lb_target_group" "alb_tg" {
  name     = "${var.project}-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }


  tags = {
    Name    = "${var.project}-alb_tg"
    Project = var.project
  }
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }

  tags = {
    Name    = "${var.project}-lb_listener"
    Project = var.project
  }
}
