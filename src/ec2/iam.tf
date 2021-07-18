resource "aws_iam_role_policy_attachment" "ssm_full_access" {
  role       = aws_iam_role.ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_iam_role" "ec2" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy_for_ec2.json
}

data "aws_iam_policy_document" "assume_role_policy_for_ec2" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_instance_profile" "ec2" {
  role = aws_iam_role.ec2.name
}
