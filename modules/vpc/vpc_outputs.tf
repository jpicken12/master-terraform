output "web_subnet" {
  value = aws_subnet.web.id
}

output "main_vpc_id" {
  value = aws_vpc.main.id
}