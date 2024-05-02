terraform {
    required providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
    cloud {
        organisation = "jpicken-org"
        workspace = "master-terraform"
    }
}