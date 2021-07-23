module "main_vpc" {
  source            = "./vpc"
  vpc_name          = "main"
  cidr_block_of_vpc = "10.0.0.0/16"
  cidr_block_of_subnets = {
    public_subnets = {
      ap-northeast-1a = {
        cidr_block = "10.0.1.0/24"
      }
      ap-northeast-1c = {
        cidr_block = "10.0.2.0/24"
      }
    }
    private_subnets = {
      ap-northeast-1a = {
        cidr_block = "10.0.11.0/24"
      }
      ap-northeast-1c = {
        cidr_block = "10.0.12.0/24"
      }
    }
  }
}

module "ec2" {
  source            = "./ec2"
  vpc_id            = module.main_vpc.vpc_id
  public_subnet_id  = module.main_vpc.public_subnet_id
  private_subnet_id = module.main_vpc.private_subnet_id
}
