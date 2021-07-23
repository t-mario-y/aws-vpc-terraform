resource "aws_vpc_endpoint" "vpc_endpoint" {
  service_name        = var.service_name_of_vpc_endpoint
  vpc_endpoint_type   = "Interface"
  vpc_id              = var.vpc_id
  subnet_ids          = var.subnet_ids_of_vpc_endpoint
  security_group_ids  = [aws_security_group.security_group_of_vpc_endpoint.id]
  private_dns_enabled = true
}

resource "aws_security_group" "security_group_of_vpc_endpoint" {
  vpc_id = var.vpc_id
  tags = {
    Name = "security-group-for-vpc-endpoint-of-${var.service_name_of_vpc_endpoint}"
  }
}

resource "aws_security_group_rule" "ingress_of_vpc_endpoint" {
  security_group_id = aws_security_group.security_group_of_vpc_endpoint.id
  type              = "ingress"
  cidr_blocks       = var.cidr_blocks_of_ingress_rule
  protocol          = "TCP"
  from_port         = 443
  to_port           = 443
}

resource "aws_security_group_rule" "egress_of_vpc_endpoint" {
  security_group_id = aws_security_group.security_group_of_vpc_endpoint.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
}
