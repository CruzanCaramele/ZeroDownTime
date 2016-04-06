# - create launch configuration (information about the instance and AMI to be launched)
# - create auto scaling group
# - create auto scaling policies (makes the elasticity occure, i.e scale out or scale down), 
		# set increase group size and  create alarm
		# set decrease group size

#--------------------------------------------------------------
# Launch Configuration
#--------------------------------------------------------------
resource "aws_launch_configuration" "scale_config" {
	name          = "web_servers_scale"
	image_id      = "${atlas_artifact.ZeroImage.metadata_full.ami_id}"
	instance_type = "t1.micro" 
}