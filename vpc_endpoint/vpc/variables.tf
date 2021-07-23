variable "vpc_name" {
  type = string
}

variable "cidr_block_of_vpc" {
  type = string
}

variable "cidr_block_of_subnets" {
  type = object({
    public_subnets = object({
      ap-northeast-1a = object({
        cidr_block = string
      })
      ap-northeast-1c = object({
        cidr_block = string
      })
    })
    private_subnets = object({
      ap-northeast-1a = object({
        cidr_block = string
      })
      ap-northeast-1c = object({
        cidr_block = string
      })
    })
  })
}
