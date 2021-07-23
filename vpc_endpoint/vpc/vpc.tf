resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block_of_vpc
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}
