locals {
  public_subnets = {
    ap-northeast-1a = {
      cidr = "10.0.1.0/24"
    }
    ap-northeast-1c = {
      cidr = "10.0.2.0/24"
    }
  }

  private_subnets = {
    ap-northeast-1a = {
      cidr = "10.0.11.0/24"
    }
    ap-northeast-1c = {
      cidr = "10.0.12.0/24"
    }
  }

  vpc_endpoint_services_for_ssm = [
    "com.amazonaws.ap-northeast-1.ssm",
    "com.amazonaws.ap-northeast-1.ssmmessages",
    "com.amazonaws.ap-northeast-1.ec2messages"
  ]
}
