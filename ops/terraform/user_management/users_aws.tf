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
resource "aws_iam_access_key" {
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