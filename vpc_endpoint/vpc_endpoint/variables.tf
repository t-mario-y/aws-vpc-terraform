variable "vpc_id" {
  type = string
}

variable "service_name_of_vpc_endpoint" {
  type = string
}

variable "cidr_blocks_of_ingress_rule" {
  type = list(string)
}

variable "subnet_ids_of_vpc_endpoint" {
  type = list(string)
}
