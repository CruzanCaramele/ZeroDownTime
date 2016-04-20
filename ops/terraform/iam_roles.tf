#--------------------------------------------------------------
# Instances iam role
#--------------------------------------------------------------
resource "aws_iam_role" "webInstanceRole" {
	name               = "webinstancerole"
	assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

#--------------------------------------------------------------
# Role Policy
#--------------------------------------------------------------
resource "aws_iam_role_policy" "webInstanceRolePolicy" {
	name   = "webinstancerolepolicy"
	role   = "${aws_iam_role.webInstanceRole.id}"
	policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": "*"
    }
  ]
}
EOF
}