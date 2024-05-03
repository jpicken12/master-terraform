terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  cloud {
    organization = var.tcp_org
    workspaces {
      name = var.tcp_workspace
    }
  }
}

# Configure the AWS Provider
provider "aws"{
  region     = var.aws_region
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

module "myvpc" {
  source = "github.com/jpicken12/master-terraform//modules/vpc"
}