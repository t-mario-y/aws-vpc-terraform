resource "aws_vpc" "secure_networking" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "secure-networking"
  }
}

resource "aws_subnet" "public_subnet_a" {
  vpc_id            = aws_vpc.secure_networking.id
  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.0.1.0/24"
  tags = {
    Name = "public-subnet-a"
  }
}

resource "aws_subnet" "public_subnet_c" {
  vpc_id            = aws_vpc.secure_networking.id
  availability_zone = "ap-northeast-1c"
  cidr_block        = "10.0.2.0/24"
  tags = {
    Name = "public-subnet-c"
  }
}

resource "aws_subnet" "private_subnet_a" {
  vpc_id            = aws_vpc.secure_networking.id
  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.0.11.0/24"
  tags = {
    Name = "private-subnet-a"
  }
}

resource "aws_subnet" "private_subnet_c" {
  vpc_id            = aws_vpc.secure_networking.id
  availability_zone = "ap-northeast-1c"
  cidr_block        = "10.0.12.0/24"
  tags = {
    Name = "private-subnet-c"
  }
}

resource "aws_internet_gateway" "secure_network" {
  vpc_id = aws_vpc.secure_networking.id
  tags = {
    Name = "igw-for-secure-network"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.secure_networking.id
  tags = {
    Name = "public-route-table-for-secure-network"
  }
}

resource "aws_route" "route_to_igw" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.secure_network.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "between_igw_route_and_public_subnet_a" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public_subnet_a.id
}

resource "aws_route_table_association" "between_igw_route_and_public_subnet_c" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public_subnet_c.id
}
