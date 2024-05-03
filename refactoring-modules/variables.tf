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

variable "dsg_parameters" {
  description = "Input variable for default security group rules"
}

variable "TFE_GITHUB_TOKEN" {
  type = string
}