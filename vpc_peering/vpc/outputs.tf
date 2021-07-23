output "public_route_table_id" {
  value = aws_route_table.public.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "vpc" {
  value = {
    id         = aws_vpc.vpc.id
    cidr_block = aws_vpc.vpc.cidr_block
  }
}
