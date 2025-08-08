# RDS Module

This Terraform module creates an RDS instance in a new VPC with associated subnets and security groups.

## Usage

```hcl
module "rds" {
  source = "./rds_module"

  prefix      = "myapp"
  db_name     = "mydb"
  db_username = "admin"
  db_password = "password"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| prefix | Prefix for all resources | `string` | `"myapp"` | no |
| vpc_cidr | CIDR block for VPC | `string` | `"10.0.0.0/16"` | no |
| db_name | Name of the database | `string` | n/a | yes |
| db_username | Username for the database | `string` | n/a | yes |
| db_password | Password for the database | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| rds_endpoint | The connection endpoint for the RDS instance |
| rds_port | The port the RDS instance is listening on |
| vpc_id | The ID of the VPC |
| subnet_ids | The IDs of the subnets |

## Notes

- This module creates an RDS instance of type t3.large in the ca-central-1 region.
- The RDS instance is created in a new VPC with two subnets across different availability zones.
- A security group is created to allow inbound traffic on port 3306 from within the VPC.
- Make sure to handle the database password securely, preferably using environment variables or a secrets management solution.
