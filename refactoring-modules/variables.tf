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

# Assign list variables, HCP Terraform doesn't handle multi-level map or list variables without having to flatten them and then
# rebuild them in the tf configutation file.
variable "dsg_parameters" {
  type = list(object({
    to_port     = number
    from_port   = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "public_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDsIaXz2gd5Cumahzdk7MWqyI8uH52su9zab6bKtT5rDXTPg0oQ/NT2y+lZEUW5TUPeyaiCUqiMEvc4kOh7VJnrs/0mkA3hLOEqAZwDx8aAsBWtTZThtllCIeIDPnpeBH7QuCEJub5f+NXD/uJHZogCCUKgmFWFhlGXB4V2nhAX5GD0eI5PC0neB7dNdN7Gc0Ra2BRE8DpGnyVHPy7wOhfuELHBrIya/5qgakuB5IOJ2HKlEsVtNEtWkA6ZbtTqZRKJCyeRKS+5Zt8gpyPV1nhxQHG3K11Pg4qtD6r75nh3MIYpcd9ZVx961hnyZqtbY3knJHZLG6RcrWysD7y2hoP3"
}

variable "server_type" {
  default = "t2.micro"
}

variable "TFE_GITHUB_TOKEN" {
  type = string
}