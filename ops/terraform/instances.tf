#--------------------------------------------------------------
# Provider
#--------------------------------------------------------------
provider "aws" {
	access_key = "${var.aws_access_key}"
	secret_key = "${var.aws_secret_key}"
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
	name   = "Zero-key"
}

#--------------------------------------------------------------
# Instance(s)
#--------------------------------------------------------------
resource "aws_instance" "zero-down-time" {
	ami                    = "${atlas_artifact.ZeroImage.metadata_full.ami_id}"
	instance_type          = "t1.micro"
	key_name               = "${module.ssh_keys.key_name}"
	availability_zone	   = "${element(split(",", var.azs), count.index)}"
	subnet_id              = "${element(aws_subnet.private_subnet.*.id, count.index)}"
	monitoring			   = true
	vpc_security_group_ids = ["${aws_security_group.default.id}"]
	depends_on             = ["aws_internet_gateway.gateway", "aws_db_instance.zero_database"]

	count = 2

	connection {
		user         = "ubuntu"
		private_key  = "${module.ssh_keys.private_key_path}"
		bastion_host = "${aws_eip.bastion_eip.public_ip}"
		bastion_key  = "${module.ssh_keys.private_key_path}"
	}

	tags {
		Name = "web-server"
	}

	lifecycle {
		create_before_destroy = true
	}
}