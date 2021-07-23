output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnets["ap-northeast-1a"].id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnets["ap-northeast-1c"].id
}
