resource "aws_vpc" "sub" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "sub"
  }
}

resource "aws_subnet" "public_subnet_of_sub" {
  vpc_id            = aws_vpc.sub.id
  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.1.0.0/24"
  tags = {
    Name = "public-subnet-of-sub"
  }
}

resource "aws_route_table" "public_route_table_of_sub" {
  vpc_id = aws_vpc.sub.id
  tags = {
    Name = "public-route-table-of-sub"
  }
}

resource "aws_internet_gateway" "sub" {
  vpc_id = aws_vpc.sub.id
  tags = {
    Name = "igw-of-sub"
  }
}

resource "aws_route_table_association" "public_route_of_sub" {
  route_table_id = aws_route_table.public_route_table_of_sub.id
  subnet_id      = aws_subnet.public_subnet_of_sub.id
}

resource "aws_route" "route_to_igw_of_sub" {
  route_table_id         = aws_route_table.public_route_table_of_sub.id
  gateway_id             = aws_internet_gateway.sub.id
  destination_cidr_block = "0.0.0.0/0"
}
