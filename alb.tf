# Create Application Load Balancer

resource "aws_lb" "alb" {
  name               = var.alb_name
  internal           = var.alb_internal
  load_balancer_type = var.alb_type
  security_groups    = [aws_security_group.alb-sg.id, data.aws_security_group.default.id]
  subnets            = [for subnet in aws_subnet.public_subnets : subnet.id]
  depends_on         = [aws_internet_gateway.igw, data.aws_security_group.default]

  tags = {
    Name = var.alb_tag
  }
}

# Create Application Load Balancer listener
resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.alb_listener_port
  protocol          = var.alb_listener_protocol
  depends_on        = [aws_lb.alb]
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-target-group.arn
  }
}

# Create Target group
resource "aws_lb_target_group" "alb-target-group" {
  name       = var.target_group_name
  depends_on = [aws_vpc.private_vpc]
  port       = var.target_group_port
  protocol   = var.target_group_protocol
  vpc_id     = aws_vpc.private_vpc.id
  slow_start = var.target_group_slow_start

  health_check {
    path                = var.health_check_path
    interval            = var.health_check_interval
    timeout             = var.health_check_timeout
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
  }

  tags = {
    Name = var.alb_target_group_tag
  }
}

# Attach Existing EC2 instances to the target group
resource "aws_lb_target_group_attachment" "alb_tg_attachment" {
  for_each = {
    for k, v in aws_instance.web :
    k => v
  }
  target_group_arn = aws_lb_target_group.alb-target-group.arn
  target_id        = each.value.id
  port             = var.target_group_port

  depends_on = [aws_instance.web]
}
