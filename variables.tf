### AWS TAGS ###
variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

### PROJECT TAGS ###

variable "project_tag" {
  type        = map(string)
  description = "Tags for the project"
  default = {
    Terraform = "true"
    Project   = "epam-tf-lab"
    Owner     = "Aleksandre_Mikashavidze"
  }
}


### EC2 VARIABLES ###

variable "linux_distro" {
  type        = string
  description = "Linux distribution for the EC2 instance"
  default     = "ubuntu"
}

variable "ami_id" {
  type        = string
  description = "AMI ID for the EC2 instance"
  default     = "ami-005fc0f236362e99f"
}

variable "ec2_name_tag" {
  type        = string
  description = "Name tag for the EC2 instance"
  default     = "web-instance"
}

variable "instance_type" {
  type        = string
  description = "Instance type for the EC2 instance"
  default     = "t3.micro"
}

variable "key_name" {
  type        = string
  description = "Name of the key pair"
  default     = "web-key"
}

variable "volume_type" {
  type        = string
  description = "List of volume types for the root block device"
  default     = "gp3"
}

variable "volume_size" {
  type        = number
  description = "Size of the root block device in GB"
  default     = 8
}

### VPC VARIABLES ###

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  type        = string
  description = "CIDR block for the first public subnet"
  default     = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  type        = string
  description = "CIDR block for the second public subnet"
  default     = "10.0.2.0/24"
}

variable "private_subnet_1_cidr" {
  type        = string
  description = "CIDR block for the first private subnet"
  default     = "10.0.3.0/24"
}

variable "private_subnet_2_cidr" {
  type        = string
  description = "CIDR block for the second private subnet"
  default     = "10.0.4.0/24"
}

variable "availability_zone_1" {
  type        = string
  description = "Availability zone for the first subnet"
  default     = "us-east-1a"
}

variable "availability_zone_2" {
  type        = string
  description = "Availability zone for the second subnet"
  default     = "us-east-1b"
}

### SECURITY GROUP VARIABLES ###

variable "website_access_cidr" {
  type        = string
  description = "CIDR block for website access"
  default     = "0.0.0.0/0"
}

variable "instance_access_cidr" {
  type        = string
  description = "CIDR block for instance access"
  default     = "0.0.0.0/0"
}

variable "website_access_port" {
  type        = number
  description = "List of ports for website access"
  default     = 80
}

variable "instance_access_port" {
  type        = number
  description = "List of ports for instance access"
  default     = 22
}

variable "icmp_access_cidr" {
  type        = string
  description = "CIDR block for ICMP access"
  default     = "0.0.0.0/0"
}

variable "ec2_sg_tag" {
  type        = string
  description = "Tag for the EC2 security group"
  default     = "ec2-security-group"
}

variable "alb_sg_tag" {
  type        = string
  description = "Tag for the ALB security group"
  default     = "alb-security-group"
}

### ALB VARIABLES ###

variable "alb_name" {
  type        = string
  description = "Name of the Application Load Balancer"
  default     = "alb"
}

variable "alb_internal" {
  type        = bool
  description = "Whether the ALB is internal"
  default     = false
}

variable "alb_type" {
  type        = string
  description = "Type of the Application Load Balancer"
  default     = "application"
}

variable "alb_listener_port" {
  type        = number
  description = "Port for the ALB listener"
  default     = 80
}

variable "alb_listener_protocol" {
  type        = string
  description = "Protocol for the ALB listener"
  default     = "HTTP"
}

variable "target_group_name" {
  type        = string
  description = "Name of the target group"
  default     = "target"
}

variable "target_group_port" {
  type        = number
  description = "Port for the target group"
  default     = 80
}

variable "target_group_protocol" {
  type        = string
  description = "Protocol for the target group"
  default     = "HTTP"
}

variable "target_group_slow_start" {
  type        = number
  description = "Slow start duration for the target group"
  default     = 30
}

variable "health_check_path" {
  type        = string
  description = "Path for the health check"
  default     = "/"
}

variable "health_check_interval" {
  type        = number
  description = "Interval for the health check"
  default     = 45
}

variable "health_check_timeout" {
  type        = number
  description = "Timeout for the health check"
  default     = 5
}

variable "health_check_healthy_threshold" {
  type        = number
  description = "Healthy threshold for the health check"
  default     = 3
}

variable "health_check_unhealthy_threshold" {
  type        = number
  description = "Unhealthy threshold for the health check"
  default     = 3
}

variable "alb_tag" {
  type        = string
  description = "Tag for the ALB"
  default     = "alb"
}

variable "alb_target_group_tag" {
  type        = string
  description = "Tag for the ALB target group"
  default     = "alb-target-group"
}

### SECURITY GROUP NAMES ###

variable "ec2_sg_name" {
  type        = string
  description = "Name of the EC2 security group"
  default     = "ec2-sg"
}

variable "alb_sg_name" {
  type        = string
  description = "Name of the ALB security group"
  default     = "alb-sg"
}

### VPC TAG NAMES ###

variable "vpc_tag_name" {
  type        = string
  description = "Tag name for the VPC"
  default     = "private-vpc"
}

variable "public_subnet_1_tag" {
  type        = string
  description = "Tag name for the first public subnet"
  default     = "public-subnet-1"
}

variable "public_subnet_2_tag" {
  type        = string
  description = "Tag name for the second public subnet"
  default     = "public-subnet-2"
}

variable "private_subnet_1_tag" {
  type        = string
  description = "Tag name for the first private subnet"
  default     = "private-subnet-1"
}

variable "private_subnet_2_tag" {
  type        = string
  description = "Tag name for the second private subnet"
  default     = "private-subnet-2"
}

variable "internet_gateway_tag" {
  type        = string
  description = "Tag name for the internet gateway"
  default     = "internet-gateway"
}

variable "nat_gateway_tag" {
  type        = string
  description = "Tag name for the NAT gateway"
  default     = "nat-gateway"
}

variable "public_route_table_tag" {
  type        = string
  description = "Tag name for the public route table"
  default     = "public-route-table"
}

variable "private_route_table_tag" {
  type        = string
  description = "Tag name for the private route table"
  default     = "private-route-table"
}
