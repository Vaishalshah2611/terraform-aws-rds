# Java SpringBoot Application Infrastructure

This Terraform module sets up the infrastructure for a Java SpringBoot application on AWS. It includes:

- VPC with a public subnet
- EC2 instance running a simple web server
- ElastiCache Redis cluster
- DynamoDB table
- Necessary security groups and IAM roles

## Prerequisites

- AWS account
- Terraform installed
- AWS CLI configured with appropriate credentials

## Usage

1. Clone this repository
2. Navigate to the module directory
3. Initialize Terraform:
   ```
   terraform init
   ```
4. Review and modify variables in `variables.tf` as needed
5. Apply the Terraform configuration:
   ```
   terraform apply
   ```
6. When prompted, enter the name of your EC2 key pair

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws_region | AWS region | string | "us-west-2" | no |
| project_name | Name of the project | string | "java-springboot-app" | no |
| vpc_cidr | CIDR block for VPC | string | "10.0.0.0/16" | no |
| public_subnet_cidr | CIDR block for public subnet | string | "10.0.1.0/24" | no |
| ec2_ami | AMI ID for EC2 instance | string | "ami-0c55b159cbfafe1f0" | no |
| ec2_instance_type | Instance type for EC2 | string | "t2.micro" | no |
| key_pair_name | Name of the key pair for EC2 instance | string | n/a | yes |
| cache_node_type | Node type for ElastiCache cluster | string | "cache.t3.micro" | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | ID of the VPC |
| public_subnet_id | ID of the public subnet |
| ec2_instance_public_ip | Public IP address of the EC2 instance |
| elasticache_endpoint | Endpoint of the ElastiCache cluster |
| dynamodb_table_name | Name of the DynamoDB table |

## Notes

- The EC2 instance is configured with a simple web server for demonstration purposes. Replace the user data script in the EC2 resource with your application deployment script.
- Adjust security group rules as needed for your application.
- Consider using private subnets and a NAT gateway for improved security in a production environment.
- Review and adjust IAM permissions as necessary for your specific use case.
