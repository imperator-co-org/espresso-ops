resource "aws_iam_policy" "ec2_instance_connect_policy" {
  name        = "${local.prefix}-${var.instance_name}-ec2instanceconnectpolicy"
  description = "Allows the use of EC2 Instance Connect to connect to instances"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2-instance-connect:SendSSHPublicKey"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_role" "ec2_instance_connect_role" {
  name = "${local.prefix}-${var.instance_name}-ec2instanceconnectrole"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.ec2_instance_connect_role.name
  policy_arn = aws_iam_policy.ec2_instance_connect_policy.arn
}

resource "aws_iam_instance_profile" "ec2_instance_connect_profile" {
  name = "${local.prefix}-${var.instance_name}-ec2instanceconnectprofile"
  role = aws_iam_role.ec2_instance_connect_role.name
}
