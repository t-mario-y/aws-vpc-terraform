resource "aws_iam_role_policy_attachment" "ssm_login" {
  role       = aws_iam_role.ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "s3_read_only" {
  role       = aws_iam_role.ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
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
