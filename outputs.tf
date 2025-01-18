output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.alb.dns_name
}

output "ec2_private_ips" {
  description = "The private IP addresses of the EC2 instances"
  value       = [for instance in aws_instance.web : instance.private_ip]
}

output "public_subnet_cidrs" {
  description = "The CIDR blocks of the public subnets"
  value       = [for subnet in aws_subnet.public_subnets : subnet.cidr_block]
}

output "private_subnet_cidrs" {
  description = "The CIDR blocks of the private subnets"
  value       = [for subnet in aws_subnet.private_subnets : subnet.cidr_block]
}