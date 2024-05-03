# Default Security Group
resource "aws_default_security_group" "default_sec_group" {
  vpc_id = module.myvpc.main_vpc_id

  dynamic "ingress" {
    for_each = var.dsg_parameters
    content {
        from_port = ingress.value["from_port"]
        to_port = ingress.value["to_port"]
        protocol = ingress.value["protocol"]
        cidr_blocks = ingress.value["cidr_blocks"]
    }
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "Default Security Group"
  }
}