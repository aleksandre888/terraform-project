resource "aws_instance" "web" {
for_each = {
    "web-instance-1" = aws_subnet.private_subnets["private_subnet_1"].id
    "web-instance-2" = aws_subnet.private_subnets["private_subnet_2"].id
}

  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = each.value
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.ec2-sg.id]

  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
  }

  tags = {
    Name = "${each.key}"
  }

  user_data = base64encode(data.template_file.user_data.rendered)
}