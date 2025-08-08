terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "ca-central-1"
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.prefix}-vpc"
  }
}

resource "aws_subnet" "main" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.prefix}-subnet-${count.index + 1}"
  }
}

resource "aws_db_subnet_group" "main" {
  name       = "${var.prefix}-db-subnet-group"
  subnet_ids = aws_subnet.main[*].id

  tags = {
    Name = "${var.prefix}-db-subnet-group"
  }
}

resource "aws_security_group" "db" {
  name        = "${var.prefix}-db-sg"
  description = "Security group for RDS instance"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  tags = {
    Name = "${var.prefix}-db-sg"
  }
}

resource "aws_db_instance" "main" {
  identifier           = "${var.prefix}-db"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.large"
  allocated_storage    = 20
  storage_type         = "gp2"
  db_name              = var.db_name
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.db.id]

  tags = {
    Name = "${var.prefix}-db"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}
