resource "aws_vpc" "secure_networking" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "secure-networking"
  }
}
