terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  cloud {
    organization = "jpicken-org"
    workspaces {
      name = "master-terraform"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = var.aws_region
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

module "vpc" {
  source = "github.com/jpicken12/master-terraform//modules/vpc"
}

module "my_dsg" {
  source         = "github.com/jpicken12/master-terraform//modules/dsg"
  main_vpc_id    = module.vpc.main_vpc_id
  dsg_parameters = var.dsg_parameters
}

module "ec2" {
  source = "github.com/jpicken12/master-terraform//modules/ec2"
  web_subnet = module.vpc.web_subnet
  dsg_sec_group_id = module.dsg_sec_group_id
  public_key = var.public_key
  server_type = var.server_type
}