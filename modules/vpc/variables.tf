variable "main_vpc_name" {
  type = string
  description = "Name of the main VPC"
  default = "main-vpc"
}

variable "subnet_zone" {
  type = string
  description = "Name of the subnet availability zone"
  default = "us-west-1a"
}

variable "vpc_cidr_block" {
  type = string
  description = "CIDR range for VPC"
  default = "10.0.0.0/16"
}

variable "web_subnet" {
  type = string
  description = "CIDR range for web subnet"
  default = "10.0.10.0/24"
}