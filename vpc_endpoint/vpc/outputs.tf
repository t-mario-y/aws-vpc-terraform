output "vpc" {
  value = {
    id = aws_vpc.vpc.id
    cidr_block = aws_vpc.vpc.cidr_block
  }
}

output "public_subnet_ids" {
  value = {
    ap-northeast-1a = aws_subnet.public_subnets["ap-northeast-1a"].id
    ap-northeast-1c = aws_subnet.public_subnets["ap-northeast-1c"].id
  }
}

output "private_subnet_ids" {
  value = {
    ap-northeast-1a = aws_subnet.private_subnets["ap-northeast-1a"].id
    ap-northeast-1c = aws_subnet.private_subnets["ap-northeast-1c"].id
  }
}

output "private_route_table_id" {
  value = aws_route_table.private.id
}
