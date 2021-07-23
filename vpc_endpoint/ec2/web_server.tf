resource "aws_instance" "web_server" {
  ami                         = "ami-0b276ad63ba2d6009"
  instance_type               = "t2.micro"
  subnet_id                   = var.public_subnet_id
  iam_instance_profile        = aws_iam_instance_profile.ec2.name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.web_server.id]

  user_data = <<EOF
#!/bin/bash

yum -y update
yum -y install httpd
systemctl enable httpd.service
systemctl start httpd.service
EOF

  tags = {
    Name = "web"
  }
}

resource "aws_security_group" "web_server" {
  vpc_id = var.vpc_id
  tags = {
    Name = "web-server"
  }
}

resource "aws_security_group_rule" "web_server_ingress_rule" {
  security_group_id = aws_security_group.web_server.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "TCP"
  from_port         = 80
  to_port           = 80
}

resource "aws_security_group_rule" "web_server_egress_rule" {
  security_group_id = aws_security_group.web_server.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
}

resource "aws_security_group_rule" "ssh_ingress_rule" {
  security_group_id = aws_security_group.web_server.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"] //実際に使用するときは、SSH接続を許可する特定IP範囲を指定する。
  protocol          = "TCP"
  from_port         = 22
  to_port           = 22
}
