# RDS Terraform Module

This Terraform module creates an RDS instance in AWS, along with the necessary networking components.

## Features

- Creates a VPC with two subnets across different Availability Zones
- Sets up a DB subnet group
- Configures a security group for the RDS instance
- Provisions an RDS instance (PostgreSQL) with the specified configuration

## Usage

```hcl
module "rds" {
  source = "./path/to/module"

  prefix      = "myapp"
  vpc_cidr    = "10.0.0.0/16"
  db_username = "admin"
  db_password = "password"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| prefix | Prefix to use for resource names | `string` | `"myapp"` | no |
| vpc_cidr | CIDR block for the VPC | `string` | `"10.0.0.0/16"` | no |
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

- The RDS instance is created with `db.t3.large` instance class in the `ca-central-1` region.
- The module creates a PostgreSQL 13 database.
- The RDS instance is configured to skip the final snapshot for easier cleanup.

## Security Considerations

- The database password is marked as sensitive. Ensure you're using secure methods to pass this value.
- The security group allows inbound traffic on port 5432 only from within the VPC.

## License

This module is released under the MIT License.