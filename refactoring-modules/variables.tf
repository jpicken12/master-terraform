variable "aws_region" {
  type = string
  default = "us-west-1"
}

variable "AWS_ACCESS_KEY_ID" {
  type = string
}

variable "AWS_SECRET_ACCESS_KEY" {
  type = string
}

variable "tcp_org" {
  type    = string
  default = "jpicken-org"
}

variable "tcp_workspace" {
    type = string
    default = "master-terraform"
}