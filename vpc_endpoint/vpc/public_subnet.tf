resource "aws_subnet" "public_subnets" {
  for_each = var.cidr_block_of_subnets.public_subnets

  vpc_id            = aws_vpc.vpc.id
  availability_zone = each.key
  cidr_block        = each.value.cidr_block
  tags = {
    Name = "public-subnet-at-${each.key}-of-${each.key}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "public-route-table-of-${var.vpc_name}"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "igw-of-${var.vpc_name}"
  }
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public_subnets

  route_table_id = aws_route_table.public.id
  subnet_id      = each.value.id
}

resource "aws_route" "route_to_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.internet_gateway.id
  destination_cidr_block = "0.0.0.0/0"
}
