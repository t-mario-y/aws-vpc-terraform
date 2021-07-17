resource "aws_iam_role_policy_attachment" "ssm_full_access" {
  role       = aws_iam_role.web_server.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_iam_role" "web_server" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy_for_web_server.json
}

data "aws_iam_policy_document" "assume_role_policy_for_web_server" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_instance_profile" "web_server" {
  role = aws_iam_role.web_server.name
}
