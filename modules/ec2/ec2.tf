terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Create a data source to fetch the latest Amazon Linux 2 Image in your region
data "aws_ami" "latest_amazon_linux2"{
  owners = ["amazon"]
  most_recent = true
  filter{
    name = "name"
    values = ["amzn2-ami-kernel-*-x86_64-gp2"]
  }

  filter {
    name = "architecture"
    values = ["x86_64"]
  }
}

data "aws_ami" "latest_amazon_macos" {
  owners = ["amazon"]
  most_recent = true
  filter{
    name = "name"
    values = ["amzn-ec2-macos-12.7.6-20240814-231426"]
  }
}

resource "aws_instance" "server" {
    ami = data.aws_ami.latest_amazon_macos.id
    instance_type = var.server_type
    subnet_id = var.web_subnet
    vpc_security_group_ids = [var.dsg_sec_group_id]
    associate_public_ip_address = true
    key_name = "testing_ssh_key"
    #user_data = <<-EOF
    #    #!/bin/bash
    #    sudo yum -y update && sudo yum -y install httpd
    #    sudo systemctl start httpd && sudo systemctl enable httpd 
    #    sudo echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html

    #    sudo yum -y install docker
    #    sudo systemctl start docker
    #    sudo usermod -aG docker ec2-user
    #    sudo docker container run -d -p 8080:80 nginx
    #EOF
    #tags = {
    #    "Name" = "My EC2 Intance - Amazon Linux 2"
    #}
}

# Creating a key-pair resource 
resource "aws_key_pair" "test_ssh_key"{
  key_name = "testing_ssh_key"
  public_key = var.public_key
}