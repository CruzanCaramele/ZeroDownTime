module "ami" {
	source = "github.com/terraform-community-modules/tf_aws_ubuntu_ami"
	region = "us-east-1"
	distribution = "trusty"
	architecture = "amd64"
	virttype = "hvm"
	storagetype = "ebs"
}

#--------------------------------------------------------------
# bastion - security group
#--------------------------------------------------------------
resource "aws_security_group" "bastion_security" {
	name        = "bastion_security"
	description = "bastion host security group"
	vpc_id      = "${aws_vpc.zero_vpc.id}"

	ingress {
		from_port   = 22
		to_port     = 22
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	lifecycle {
		create_before_destroy = true
	}
}

#--------------------------------------------------------------
# bastion - host
#--------------------------------------------------------------
resource "aws_instance" "bastion_host" {
	instance_type   = "t2.micro"
	ami             = "${module.ami.ami_id}"
	subnet_id       = "${element(aws_subnet.public.*.id, count.index)}"
	monitoring      = true
	key_name        = "${module.ssh_keys.key_name}"
	security_groups = ["${aws_security_group.bastion_security.id}"]
	depends_on      = ["aws_internet_gateway.gateway"]
	count           = 1

	tags {
		Name = "bastion_host"
	}

	connection {
		user        = "ubuntu"
		private_key = "${module.ssh_keys.private_key_path}"
	}

	lifecycle {
		create_before_destroy = true
	}
}