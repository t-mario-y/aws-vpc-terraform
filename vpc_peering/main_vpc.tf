resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "public_subnet_of_main" {
  vpc_id            = aws_vpc.main.id
  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.0.0.0/24"
  tags = {
    Name = "public-subnet-of-main"
  }
}

resource "aws_route_table" "public_route_table_of_main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "public-route-table-of-main"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "igw-of-main"
  }
}

resource "aws_route_table_association" "public_route_table_association_of_main" {
  route_table_id = aws_route_table.public_route_table_of_main.id
  subnet_id      = aws_subnet.public_subnet_of_main.id
}

resource "aws_route" "route_to_igw_of_main" {
  route_table_id         = aws_route_table.public_route_table_of_main.id
  gateway_id             = aws_internet_gateway.main.id
  destination_cidr_block = "0.0.0.0/0"
}
