module "example_vpc" {
  source            = "./vpc"
  vpc_name          = "vpc-endpoint-example"
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

resource "aws_vpc_endpoint" "s3" {
  service_name      = "com.amazonaws.ap-northeast-1.s3"
  vpc_endpoint_type = "Gateway"
  vpc_id            = module.example_vpc.vpc.id
  route_table_ids   = [module.example_vpc.private_route_table_id]
}

module "vpc_endpoint" {
  for_each                     = toset(local.vpc_endpoint_services_for_ssm)
  source                       = "./vpc_endpoint"
  service_name_of_vpc_endpoint = each.value
  vpc_id                       = module.example_vpc.vpc.id
  cidr_blocks_of_ingress_rule  = [module.example_vpc.vpc.cidr_block]
  subnet_ids_of_vpc_endpoint   = [module.example_vpc.public_subnet_ids.ap-northeast-1c]
}

module "ec2" {
  source            = "./ec2"
  vpc_id            = module.example_vpc.vpc.id
  public_subnet_id  = module.example_vpc.public_subnet_ids.ap-northeast-1a
  private_subnet_id = module.example_vpc.private_subnet_ids.ap-northeast-1c
}
