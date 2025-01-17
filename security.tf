resource "aws_security_group" "ec2-sg" {
  name        = var.ec2_sg_name
  description = "Allow traffic from VPC"
  vpc_id      = aws_vpc.private_vpc.id
  depends_on = [
    aws_vpc.private_vpc, aws_security_group.alb-sg
  ]

  dynamic "ingress" {
    for_each = [
      {
        from_port = 0
        to_port   = 0
        protocol  = "-1"
      },
      {
        from_port   = -1
        to_port     = -1
        protocol    = "icmp"
        cidr_blocks = [var.website_access_cidr]
      },
      {
        from_port       = var.website_access_port
        to_port         = var.website_access_port
        protocol        = "tcp"
        security_groups = [aws_security_group.alb-sg.id]
      },
      {
        from_port   = var.instance_access_port
        to_port     = var.instance_access_port
        protocol    = "tcp"
        cidr_blocks = [var.instance_access_cidr]
      }
    ]

    content {
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      cidr_blocks     = lookup(ingress.value, "cidr_blocks", null)
      security_groups = lookup(ingress.value, "security_groups", null)
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [var.website_access_cidr]
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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.website_access_cidr]
  }

  tags = {
    Name = var.alb_sg_tag
  }
}
