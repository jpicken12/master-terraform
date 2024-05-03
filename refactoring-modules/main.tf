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