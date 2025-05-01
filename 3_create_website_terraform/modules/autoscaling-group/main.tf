resource "aws_launch_template" "launch_template" {
  name_prefix            = "${var.project}-launch-template"
  image_id               = var.image_id[var.region]
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.allow_http_id, var.allow_ssh_id]
  user_data              = filebase64(var.startup_script)
}

resource "aws_autoscaling_group" "auto-scaling" {
  name              = "${var.project}-asg"
  min_size          = var.instance_count_min
  max_size          = var.instance_count_max
  health_check_type = "ELB"
  target_group_arns = [var.target_group_arn]

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }

  vpc_zone_identifier = [
    var.subnet_a_id,
    var.subnet_b_id
  ]

  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "${var.project}-webserver"
    propagate_at_launch = true
  }
}
