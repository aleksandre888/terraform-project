data "template_file" "user_data" {
  template = file("script.sh")
}

data "aws_security_group" "default" {
  vpc_id = aws_vpc.private_vpc.id

  filter {
    name   = "group-name"
    values = ["default"]
  }
}