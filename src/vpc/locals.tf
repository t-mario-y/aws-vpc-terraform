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
}
