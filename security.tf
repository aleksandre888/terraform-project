resource "aws_security_group" "ec2-sg" {
  name        = var.ec2_sg_name
  description = "Allow traffic from VPC"
  vpc_id      = aws_vpc.private_vpc.id
  depends_on = [
    aws_vpc.private_vpc, aws_security_group.alb-sg
  ]

  dynamic "ingress" {
    for_each = var.ec2_ingress_rules
    content {
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      cidr_blocks     = ingress.value.cidr_blocks
      security_groups = [for sg in ingress.value.security_groups : sg == "alb_sg_placeholder" ? aws_security_group.alb-sg.id : sg]
    }
  }

  dynamic "egress" {
    for_each = var.ec2_egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = var.ec2_sg_tag
  }
}

# Application Load balancer security group
resource "aws_security_group" "alb-sg" {
  name        = var.alb_sg_name
  description = "load balancer security group"
  vpc_id      = aws_vpc.private_vpc.id
  depends_on = [
    aws_vpc.private_vpc
  ]

  dynamic "ingress" {
    for_each = var.alb_ingress_rules
    content {
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      cidr_blocks     = ingress.value.cidr_blocks
      security_groups = ingress.value.security_groups
    }
  }

  dynamic "egress" {
    for_each = var.alb_egress_rules
    content {
      from_port       = egress.value.from_port
      to_port         = egress.value.to_port
      protocol        = egress.value.protocol
      cidr_blocks     = egress.value.cidr_blocks
      security_groups = egress.value.security_groups
    }
  }
  tags = {
    Name = var.alb_target_group_tag
  }
}