resource "aws_vpc" "secure_networking" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "secure-networking"
  }
}

resource "aws_vpc_endpoint" "ssm_services" {
  for_each = toset(local.vpc_endpoint_services_for_ssm)

  service_name        = each.value
  vpc_endpoint_type   = "Interface"
  vpc_id              = aws_vpc.secure_networking.id
  subnet_ids          = [aws_subnet.public_subnets["ap-northeast-1c"].id]
  security_group_ids  = [aws_security_group.vpc_endpoint_for_ssm_services.id]
  private_dns_enabled = true
}

resource "aws_security_group" "vpc_endpoint_for_ssm_services" {
  vpc_id = aws_vpc.secure_networking.id
}

resource "aws_security_group_rule" "ingress_of_vpc_endpoint_for_ssm_services" {
  security_group_id = aws_security_group.vpc_endpoint_for_ssm_services.id
  type              = "ingress"
  cidr_blocks       = [aws_vpc.secure_networking.cidr_block]
  protocol          = "TCP"
  from_port         = 443
  to_port           = 443
}

resource "aws_security_group_rule" "egress_of_vpc_endpoint_for_ssm_services" {
  security_group_id = aws_security_group.vpc_endpoint_for_ssm_services.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
}
