variable "dsg_parameters" {
  description = "Parameters to use for ingress and egress rules i.e. from_port to_port etc"
  type = list(object({
    to_port     = number
    from_port   = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "main_vpc_id" {
  
}