resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block_of_vpc
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_vpc_endpoint" "ssm_services" {
  for_each = toset(local.vpc_endpoint_services_for_ssm)

  service_name        = each.value
  vpc_endpoint_type   = "Interface"
  vpc_id              = aws_vpc.vpc.id
  subnet_ids          = [aws_subnet.public_subnets["ap-northeast-1c"].id]
  security_group_ids  = [aws_security_group.vpc_endpoint_for_ssm_services.id]
  private_dns_enabled = true
}

resource "aws_security_group" "vpc_endpoint_for_ssm_services" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_security_group_rule" "ingress_of_vpc_endpoint_for_ssm_services" {
  security_group_id = aws_security_group.vpc_endpoint_for_ssm_services.id
  type              = "ingress"
  cidr_blocks       = [aws_vpc.vpc.cidr_block]
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

resource "aws_vpc_endpoint" "s3_access_for_private_subnets" {
  service_name      = "com.amazonaws.ap-northeast-1.s3"
  vpc_endpoint_type = "Gateway"
  vpc_id            = aws_vpc.vpc.id
  route_table_ids   = [aws_route_table.private.id]
}
