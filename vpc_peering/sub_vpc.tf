module "sub_vpc" {
  source = "./vpc"
  vpc_name                    = "sub"
  cidr_block_of_vpc           = "10.1.0.0/16"
  cidr_block_of_public_subnet = "10.1.0.0/24"
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
  subnet_id       = module.sub_vpc.public_subnet_id
  private_ips     = ["10.1.0.100"]
  security_groups = [aws_security_group.peering_test.id]
  tags = {
    Name = "peering-test"
  }
}

resource "aws_security_group" "peering_test" {
  vpc_id = module.sub_vpc.vpc.id
}

resource "aws_security_group_rule" "peering_test_ingress_rule" {
  security_group_id = aws_security_group.peering_test.id
  type              = "ingress"
  cidr_blocks       = [module.main_vpc.vpc.cidr_block]
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
