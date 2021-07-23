resource "aws_route" "route_to_peering_connection_of_main" {
  route_table_id            = aws_route_table.public_route_table_of_main.id
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection.id
  destination_cidr_block    = aws_vpc.sub.cidr_block
}

resource "aws_route" "route_to_peering_connection_of_sub" {
  route_table_id            = aws_route_table.public_route_table_of_sub.id
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection.id
  destination_cidr_block    = aws_vpc.main.cidr_block
}

resource "aws_vpc_peering_connection" "peering_connection" {
  vpc_id      = aws_vpc.main.id
  peer_vpc_id = aws_vpc.sub.id
  auto_accept = true
}

resource "aws_instance" "peering_test" {
  ami           = "ami-0b276ad63ba2d6009"
  instance_type = "t2.micro"
  network_interface {
    network_interface_id = aws_network_interface.peering_test.id
    device_index         = 0
  }
  tags = {
    Name = "peering"
  }
}

resource "aws_network_interface" "peering_test" {
  subnet_id       = aws_subnet.public_subnet_of_sub.id
  private_ips     = ["10.1.0.100"]
  security_groups = [aws_security_group.peering_test.id]
  tags = {
    Name = "peering-test"
  }
}

resource "aws_security_group" "peering_test" {
  vpc_id = aws_vpc.sub.id
}

resource "aws_security_group_rule" "peering_test_ingress_rule" {
  security_group_id = aws_security_group.peering_test.id
  type              = "ingress"
  cidr_blocks       = [aws_vpc.main.cidr_block]
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
}

resource "aws_security_group_rule" "peering_test_egress_rule" {
  security_group_id = aws_security_group.peering_test.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
}
