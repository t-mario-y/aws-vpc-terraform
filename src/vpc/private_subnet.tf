resource "aws_subnet" "private_subnets" {
  for_each = local.private_subnets

  vpc_id            = aws_vpc.secure_networking.id
  availability_zone = each.key
  cidr_block        = each.value.cidr
  tags = {
    Name = "private-subnet-of-${each.key}"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.secure_networking.id
  tags = {
    Name = "private-route-table-for-secure-network"
  }
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private_subnets

  route_table_id = aws_route_table.private.id
  subnet_id      = each.value.id
}

//VPCエンドポイントを設定することにより、NAT Gatewayの設定不要でSSMログインが可能である。
//ただし、インターネットへのアクセスが不可能になる。
resource "aws_nat_gateway" "secure_network" {
  allocation_id = aws_eip.eip_for_nat_gateway.id
  subnet_id     = aws_subnet.public_subnets["ap-northeast-1c"].id
}

resource "aws_eip" "eip_for_nat_gateway" {
  vpc = true
}

resource "aws_route" "route_to_nat_gateway" {
  route_table_id         = aws_route_table.private.id
  nat_gateway_id         = aws_nat_gateway.secure_network.id
  destination_cidr_block = "0.0.0.0/0"
}
