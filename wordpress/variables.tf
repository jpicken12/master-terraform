variable "ami" {
  type = string
}
variable "aws_region" {
  type    = string
  default = "us-west-1"
}

variable "AWS_ACCESS_KEY_ID" {
  type = string
}

variable "AWS_SECRET_ACCESS_KEY" {
  type = string
}

variable "azs" {
  type    = list(string)
  default = ["us-west-1a", "us-west-1c"]
}

variable "create_database_subnet_group" {
  type = bool
}

variable "database_subnets" {
  type    = list(string)
  default = ["10.0.30.0/24", "10.0.40.0/24"]
}

variable "database_subnet_group_name" {
  type = string
}

variable "dns-server-name" {
  type = string
}

variable "instance-type" {
  type = string
}

variable "my-ip" {
  type = string
}
variable "name" {
  type = string
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.10.0/24", "10.0.20.0/24"]
}

variable "public_key" {

}

variable "ssh-security-group-name" {
  type = string
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

# variable "public_key" {
#   default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDsIaXz2gd5Cumahzdk7MWqyI8uH52su9zab6bKtT5rDXTPg0oQ/NT2y+lZEUW5TUPeyaiCUqiMEvc4kOh7VJnrs/0mkA3hLOEqAZwDx8aAsBWtTZThtllCIeIDPnpeBH7QuCEJub5f+NXD/uJHZogCCUKgmFWFhlGXB4V2nhAX5GD0eI5PC0neB7dNdN7Gc0Ra2BRE8DpGnyVHPy7wOhfuELHBrIya/5qgakuB5IOJ2HKlEsVtNEtWkA6ZbtTqZRKJCyeRKS+5Zt8gpyPV1nhxQHG3K11Pg4qtD6r75nh3MIYpcd9ZVx961hnyZqtbY3knJHZLG6RcrWysD7y2hoP3"
# }

# variable "server_type" {
#   default = "t2.micro"
# }

# variable "TFE_GITHUB_TOKEN" {
#   type = string
# }