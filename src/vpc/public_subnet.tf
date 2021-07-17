resource "aws_subnet" "public_subnets" {
  for_each = local.public_subnets

  vpc_id            = aws_vpc.secure_networking.id
  availability_zone = each.key
  cidr_block        = each.value.cidr
  tags = {
    Name = "public-subnet-of-${each.key}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.secure_networking.id
  tags = {
    Name = "public-route-table-for-secure-network"
  }
}

resource "aws_internet_gateway" "secure_network" {
  vpc_id = aws_vpc.secure_networking.id
  tags = {
    Name = "igw-for-secure-network"
  }
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public_subnets

  route_table_id = aws_route_table.public.id
  subnet_id      = each.value.id
}

resource "aws_route" "route_to_igw" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.secure_network.id
  destination_cidr_block = "0.0.0.0/0"
}
