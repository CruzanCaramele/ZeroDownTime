module "ami" {
	source = "github.com/terraform-community-modules/tf_aws_ubuntu_ami"
	region = "eu-central-1"
	distribution = "trusty"
	architecture = "amd64"
	virttype = "hvm"
	storagetype = "instance-store"
}

#--------------------------------------------------------------
# bastion - host
#--------------------------------------------------------------
resource "aws_instance" "bastion_host" {
	instance_type = "t1.micro"
	ami           = "${module.ami.ami_id}"
}