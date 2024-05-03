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

# Assign list variables, HCP Terraform doesn't handle multi-level map or list variables without having to flatten them and then
# rebuild them in the tf configutation file. So... what's the point.
variable "dsg_parameters" {
  type = list(object({
    http = {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = "0.0.0.0/0"
    },
    http_8080 = {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = "0.0.0.0/0"
    },
    ssh = {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = "0.0.0.0/0"
    }
  }))  
}

module "vpc" {
  source = "github.com/jpicken12/master-terraform//modules/vpc"
}

module "my_dsg" {
  source = "github.com/jpicken12/master-terraform//modules/dsg"
  main_vpc_id = module.vpc.main_vpc_id
  dsg_parameters = var.dsg_parameters
}