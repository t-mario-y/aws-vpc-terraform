output "vpc_id" {
  value = aws_vpc.secure_networking.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnets["ap-northeast-1a"].id
}
