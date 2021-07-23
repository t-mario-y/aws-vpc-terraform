resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block_of_vpc
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "ap-northeast-1a"
  cidr_block        = var.cidr_block_of_public_subnet
  tags = {
    Name = "public-subnet-of-${var.vpc_name}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "public-route-table-of-${var.vpc_name}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "igw-of-${var.vpc_name}"
  }
}

resource "aws_route_table_association" "public_route_table_association" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public_subnet.id
}

resource "aws_route" "route_to_igw_of_main" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.igw.id
  destination_cidr_block = "0.0.0.0/0"
}
