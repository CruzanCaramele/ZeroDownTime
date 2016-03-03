#--------------------------------------------------------------
# Provider
#--------------------------------------------------------------
provider "aws" {
	access_key = "${var.aws_access_key}"
	secret_key = "${var.aws_secret-Key}"
	region     = "us-east-1"
}

#--------------------------------------------------------------
# Artifact(s)
#--------------------------------------------------------------
resource "atlas_artifact" "zero" {
	name    = "Panda/zero"
	type    = "amazon.ami"
	version = "latest"
}

#--------------------------------------------------------------
# Instance(s)
#--------------------------------------------------------------
resource "aws_instance" "zero-down-time" {
	ami = "${atlas_artifact.zero.metadata_full.ami_id}"
	instance_type = "t1.micro"
	subnet_id = "${aws_subnet.public.id}"
	vpc_security_group_ids = ["${aws_security_group.web.id}"]

	count = 2

	lifecycle {
		create_before_destroy = true
	}
}