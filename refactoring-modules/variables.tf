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
  type = list(object(
    {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = "0.0.0.0/0"
    },
    {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = "0.0.0.0/0"
    },
    {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = "0.0.0.0/0"
    }
  ))
}

variable "TFE_GITHUB_TOKEN" {
  type = string
}