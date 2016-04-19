#--------------------------------------------------------------
# Users
#--------------------------------------------------------------
resource "aws_iam_user" "sudoer" {
	name = "sudoer"
	path = "/"
}

#--------------------------------------------------------------
# Access_key
#--------------------------------------------------------------
resource "aws_iam_access_key" "sudoerKey" {
	user = "${aws_iam_user.sudoer.name}"
}

#--------------------------------------------------------------
# Sudo Group
#--------------------------------------------------------------
resource "aws_iam_group" "sudoers" {
	name = "sudoers"
	path = "/"
}

#--------------------------------------------------------------
# Sudo Group Policy
#--------------------------------------------------------------
resource "aws_iam_group_policy" "sudoersPolicy" {
	name   = "sudoersPolicy"
	group  = "${aws_iam_group.sudoers.id}"
	policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*"
    }
  ]
}
EOF
}

#--------------------------------------------------------------
# Sudo Group Memberships
#--------------------------------------------------------------
resource "aws_iam_group_membership" "sudoersMembers" {
	name  = "sudoersMembers"
	users = ["${aws_iam_user.sudoer.name}"]
	group = "${aws_iam_group.sudoers.name}"
}