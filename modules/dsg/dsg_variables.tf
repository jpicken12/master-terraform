variable "dsg_parameters" {
  description = "Parameters to use for ingress and egress rules i.e. from_port to_port etc"
  type = map(any)

  default = [
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
  ]
}
variable "main_vpc_id" {
  
}