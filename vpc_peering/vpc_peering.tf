resource "aws_vpc_peering_connection" "peering_connection" {
  vpc_id      = module.main_vpc.vpc.id
  peer_vpc_id = module.sub_vpc.vpc.id
  auto_accept = true
}

resource "aws_route" "route_to_peering_connection_of_main" {
  route_table_id            = module.main_vpc.public_route_table_id
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection.id
  destination_cidr_block    = module.sub_vpc.vpc.cidr_block
}

resource "aws_route" "route_to_peering_connection_of_sub" {
  route_table_id            = module.sub_vpc.public_route_table_id
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection.id
  destination_cidr_block    = module.main_vpc.vpc.cidr_block
}
