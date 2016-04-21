#--------------------------------------------------------------
# User
#--------------------------------------------------------------
resource "aws_iam_user" "visualops" {
	name = "visualops"
	path = "/"
}

#--------------------------------------------------------------
# Access_key
#--------------------------------------------------------------
resource "aws_iam_access_key" "visualops_key" {
	user = "${aws_iam_user.visualops.name}"
}

#--------------------------------------------------------------
# VisualOps Group
#--------------------------------------------------------------
resource "aws_iam_group" "visualops_group" {
	name = "visualops_group"
	path = "/"
}

#--------------------------------------------------------------
# VisualOps Group Policy
#--------------------------------------------------------------
resource "aws_iam_group_policy" "visualops_group_policy" {
	name   = "visualops_group_policy"
	group  = "${aws_iam_group.visualops_group.id}"
	policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "ec2:*",
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "elasticloadbalancing:*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "cloudwatch:*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "autoscaling:*",
      "Resource": "*"
    }
  ]
}
EOF
}

#--------------------------------------------------------------
# VisualOps Group Memberships
#--------------------------------------------------------------
resource "aws_iam_group_membership" "visualops_group_membership" {
	name  = "visualops_group_membership"
	users = ["${aws_iam_user.visualops.name}"]
	group = "${aws_iam_group.visualops_group.name}"
}