# RDS Terraform Module

This Terraform module creates an Amazon RDS instance in a custom VPC with private subnets.

## Features

- Creates a VPC with private subnets
- Sets up a DB subnet group
- Creates a security group for the RDS instance
- Provisions an RDS instance (PostgreSQL)

## Usage

```hcl
module "rds" {
  source = "./rds-module"

  region      = "ca-central-1"
  project     = "myproject"
  vpc_cidr    = "10.0.0.0/16"
  db_name     = "mydb"
  db_username = "admin"
  db_password = "password123"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| region | AWS region | string | "ca-central-1" | no |
| project | Project name | string | "myproject" | no |
| vpc_cidr | CIDR block for VPC | string | "10.0.0.0/16" | no |
| db_name | Name of the database | string | n/a | yes |
| db_username | Username for the database | string | n/a | yes |
| db_password | Password for the database | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| rds_endpoint | The connection endpoint for the RDS instance |
| rds_port | The port the RDS instance is listening on |
| vpc_id | The ID of the VPC |
| private_subnet_ids | The IDs of the private subnets |

## Notes

- The RDS instance is created in private subnets for security reasons.
- Make sure to handle the `db_password` securely and avoid committing it to version control.
- Adjust the CIDR blocks and other parameters as needed for your specific use case.
