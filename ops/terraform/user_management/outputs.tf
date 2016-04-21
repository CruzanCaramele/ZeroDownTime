#--------------------------------------------------------------
# Sudo User outputs
#--------------------------------------------------------------
output "admin_id" {
  value = "${aws_iam_user.sudoer.id}"
}

output "sudoer_arn" {
  value = "${aws_iam_user.sudoer.arn}"
}

output "sudoer_name" {
  value = "${aws_iam_user.sudoer.name}"
}

output "sudoer_access_key_id" {
  value = "${aws_iam_access_key.sudoerKey.id}"
}

output "sudoer_access_key_secret" {
  value = "${aws_iam_access_key.sudoerKey.secret}"
}

#--------------------------------------------------------------
# VisualOps User outputs
#--------------------------------------------------------------
output "visualops_id" {
  value = "${aws_iam_user.visualops.id}"
}

output "visualops_arn" {
  value = "${aws_iam_user.visualops.arn}"
}

output "visualops_name" {
  value = "${aws_iam_user.visualops.name}"
}

output "visualops_access_key_id" {
  value = "${aws_iam_access_key.visualops_key.id}"
}

output "visualops_access_key_secret" {
  value = "${aws_iam_access_key.visualops_key.secret}"
}