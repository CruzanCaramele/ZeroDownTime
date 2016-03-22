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
resource "atlas_artifact" "ZeroImage" {
	name    = "Panda/ZeroImage"
	type    = "amazon.ami"
	version = "latest"
}

#--------------------------------------------------------------
# Module(s)
#--------------------------------------------------------------
module "ssh_keys" {
	source = "./ssh_keys"
	name   = "ZeroKey"
}

#--------------------------------------------------------------
# Instance(s)
#--------------------------------------------------------------
resource "aws_instance" "zero-down-time" {
	ami                    = "${atlas_artifact.ZeroImage.metadata_full.ami_id}"
	key_name               = "${module.ssh_keys.key_name}"
	instance_type          = "t1.micro"
	subnet_id              = "${aws_subnet.public.id}"
	vpc_security_group_ids = ["${aws_security_group.default.id}, ${aws_security_group.web-ssh.id}"]
	depends_on             = ["aws_internet_gateway.gateway"]

	count = 2

	lifecycle {
		create_before_destroy = true
	}
}