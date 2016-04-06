# - create launch configuration (information about the instance and AMI to be launched)
# - create auto scaling group
# - create auto scaling policies (makes the elasticity occure, i.e scale out or scale down), 
		# set increase group size and  create alarm
		# set decrease group size

#--------------------------------------------------------------
# Launch Configuration
#--------------------------------------------------------------
resource "aws_launch_configuration" "scale_config" {
	name              = "web_servers_scale"
	image_id          = "${atlas_artifact.ZeroImage.metadata_full.ami_id}"
	instance_type     = "t1.micro"
	key_name          = "${module.ssh_keys.key_name}"
	enable_monitoring = true
	security_groups   = ["${aws_security_group.web-ssh.id}"]

	lifecycle {
		create_before_destroy = true
	}
}

#--------------------------------------------------------------
# Auto Scaling Group
#--------------------------------------------------------------
resource "aws_auto_scaling_group" "scaling_group" {
	name                = "scaling_group"
	availability_zones  = ["us-east-1a"]
	min_size            = 2
	max_size	   	    = 5
	vpc_zone_identifier = ["${aws_subnet.private_subnet.id}"]
	load_balancers      = ["${aws_elb.ZeroBalancer.name}"]
}