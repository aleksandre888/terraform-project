## Project

This project sets up a secure and scalable infrastructure on AWS using Terraform. It includes the following components:
- A VPC with public and private subnets across two availability zones.
- An Internet Gateway and a NAT Gateway for internet access.
- Security groups to control inbound and outbound traffic.
- An Application Load Balancer (ALB) to distribute traffic to EC2 instances in private subnets.
- Auto Scaling groups to manage the EC2 instances based on demand.

## Usage

To set up your environment, export your AWS credentials as environment variables:

```sh
export AWS_ACCESS_KEY_ID="your_access_key"
export AWS_SECRET_ACCESS_KEY="your_secret_key"
# Optional
export AWS_SESSION_TOKEN="your_session_token"
```

Then, initialize and apply the Terraform configuration:

```sh
terraform init
terraform apply
```

## Terraform Documentation

To generate the Terraform documentation, run:

```sh
terraform-docs markdown . > README.md
```

## Diagram

![Diagram](image.png)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.83.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.web-asg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_autoscaling_policy.web-asg-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy) | resource |
| [aws_eip.nat_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_launch_template.web-lt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_lb.alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.alb-listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.alb-target-group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_nat_gateway.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route_table.private_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private_subnet_1_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.private_subnet_2_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_subnet_association_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_subnet_association_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.instance-access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.website-access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.private_subnet_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.private_subnet_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public_subnet_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public_subnet_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.private_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | AMI ID for the EC2 instance | `map(string)` | <pre>{<br/>  "amazon2023": "ami-05576a079321f21f8",<br/>  "ubuntu2204": "ami-005fc0f236362e99f"<br/>}</pre> | no |
| <a name="input_availability_zone_1"></a> [availability\_zone\_1](#input\_availability\_zone\_1) | Availability zone for the first subnet | `string` | `"us-east-1a"` | no |
| <a name="input_availability_zone_2"></a> [availability\_zone\_2](#input\_availability\_zone\_2) | Availability zone for the second subnet | `string` | `"us-east-1b"` | no |
| <a name="input_aws_access_key_id"></a> [aws\_access\_key\_id](#input\_aws\_access\_key\_id) | value of AWS Access Key ID | `string` | n/a | yes |
| <a name="input_aws_secret_access_key"></a> [aws\_secret\_access\_key](#input\_aws\_secret\_access\_key) | value of AWS Secret Access Key | `string` | n/a | yes |
| <a name="input_aws_session_token"></a> [aws\_session\_token](#input\_aws\_session\_token) | value of AWS Session Token | `string` | n/a | yes |
| <a name="input_ec2_name_tag"></a> [ec2\_name\_tag](#input\_ec2\_name\_tag) | Name tag for the EC2 instance | `string` | `"web-instance"` | no |
| <a name="input_instance_access_cidr"></a> [instance\_access\_cidr](#input\_instance\_access\_cidr) | CIDR block for instance access | `string` | `"0.0.0.0/0"` | no |
| <a name="input_instance_access_ports"></a> [instance\_access\_ports](#input\_instance\_access\_ports) | List of ports for instance access | `list(number)` | <pre>[<br/>  22<br/>]</pre> | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type for the EC2 instance | `list(string)` | <pre>[<br/>  "t3.micro",<br/>  "t3.small",<br/>  "t3.medium",<br/>  "t3.large"<br/>]</pre> | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Name of the key pair | `string` | `"web-key"` | no |
| <a name="input_private_subnet_1_cidr"></a> [private\_subnet\_1\_cidr](#input\_private\_subnet\_1\_cidr) | CIDR block for the first private subnet | `string` | `"10.0.3.0/24"` | no |
| <a name="input_private_subnet_2_cidr"></a> [private\_subnet\_2\_cidr](#input\_private\_subnet\_2\_cidr) | CIDR block for the second private subnet | `string` | `"10.0.4.0/24"` | no |
| <a name="input_public_subnet_1_cidr"></a> [public\_subnet\_1\_cidr](#input\_public\_subnet\_1\_cidr) | CIDR block for the first public subnet | `string` | `"10.0.1.0/24"` | no |
| <a name="input_public_subnet_2_cidr"></a> [public\_subnet\_2\_cidr](#input\_public\_subnet\_2\_cidr) | CIDR block for the second public subnet | `string` | `"10.0.2.0/24"` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | Size of the root block device in GB | `number` | `8` | no |
| <a name="input_volume_type"></a> [volume\_type](#input\_volume\_type) | List of volume types for the root block device | `list(string)` | <pre>[<br/>  "standard",<br/>  "gp2",<br/>  "gp3"<br/>]</pre> | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block for the VPC | `string` | `"10.0.0.0/16"` | no |
| <a name="input_website_access_cidr"></a> [website\_access\_cidr](#input\_website\_access\_cidr) | CIDR block for website access | `string` | `"0.0.0.0/0"` | no |
| <a name="input_website_access_ports"></a> [website\_access\_ports](#input\_website\_access\_ports) | List of ports for website access | `list(number)` | <pre>[<br/>  80,<br/>  443<br/>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | The DNS name of the Application Load Balancer |
<!-- END_TF_DOCS -->