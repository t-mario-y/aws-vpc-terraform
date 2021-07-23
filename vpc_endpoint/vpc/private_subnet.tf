resource "aws_subnet" "private_subnets" {
  for_each = var.cidr_block_of_subnets.private_subnets

  vpc_id            = aws_vpc.vpc.id
  availability_zone = each.key
  cidr_block        = each.value.cidr_block
  tags = {
    Name = "private-subnet-at-${each.key}-of-${aws_vpc.vpc.tags["Name"]}"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "private-route-table-of-${var.vpc_name}"
  }
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private_subnets

  route_table_id = aws_route_table.private.id
  subnet_id      = each.value.id
}

//VPCエンドポイントを設定することにより、NAT Gatewayの設定不要でSSMログインが可能である。
//ただし、インターネットへのアクセスが不可能になる。
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip_for_nat_gateway.id
  subnet_id     = aws_subnet.public_subnets["ap-northeast-1c"].id
}

resource "aws_eip" "eip_for_nat_gateway" {
  vpc = true
}

resource "aws_route" "route_to_nat_gateway" {
  route_table_id         = aws_route_table.private.id
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
  destination_cidr_block = "0.0.0.0/0"
}
