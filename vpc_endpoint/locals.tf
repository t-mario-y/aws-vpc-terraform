locals {
  vpc_endpoint_services_for_ssm = [
    "com.amazonaws.ap-northeast-1.ssm",
    "com.amazonaws.ap-northeast-1.ssmmessages",
    "com.amazonaws.ap-northeast-1.ec2messages"
  ]
}
