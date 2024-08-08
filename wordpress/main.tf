terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.49.0"
    }
  }
  cloud {
    organization = "jpicken-org"
    workspaces {
      name = "wordpress"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = var.aws_region
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

# locals {
#   ssh-security-group-id = tolist(module.security-group_ssh.security_group_id)
# }
module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.1"

  ami                    = var.ami
  availability_zone      = var.azs[0]
  instance_type          = var.instance-type
  key_name               = var.public_key
  name                   = var.dns-server-name
  subnet_id              = module.vpc.private_subnets[0]
  vpc_security_group_ids = ["$(module.security-group_ssh.security_group_ids)"]
}

module "ssh_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.2"

  name        = var.ssh-security-group-name
  description = "Allow ssh to virtual machines"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["10.0.10.0/24"]
  ingress_rules       = ["ssh-22-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "10.0.10.0/24"
    },
    {
      rule        = "postgresql-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  azs                          = var.azs
  cidr                         = var.vpc_cidr_block
  create_database_subnet_group = var.create_database_subnet_group
  database_subnets             = var.database_subnets
  database_subnet_group_name   = var.database_subnet_group_name
  name                         = var.name
  private_subnets              = var.private_subnets
}

# Creating a key-pair resource 
resource "aws_key_pair" "test_ssh_key" {
  key_name   = "testing_ssh_key"
  public_key = var.public_key
}