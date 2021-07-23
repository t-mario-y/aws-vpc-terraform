module "main_vpc" {
  source                      = "./vpc"
  vpc_name                    = "main"
  cidr_block_of_vpc           = "10.0.0.0/16"
  cidr_block_of_public_subnet = "10.0.0.0/24"
}
