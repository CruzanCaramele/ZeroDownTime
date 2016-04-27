#--------------------------------------------------------------
# Launch Configuration
#--------------------------------------------------------------
resource "aws_launch_configuration" "scale_config" {
	name              = "web_servers_scale"
	image_id          = "${atlas_artifact.ZeroImage.metadata_full.ami_id}"
	instance_type     = "t1.micro"
	key_name          = "${module.ssh_keys.key_name}"
	enable_monitoring = true
	security_groups   = ["${aws_security_group.default.id}"]

	lifecycle {
		create_before_destroy = true
	}
}

#--------------------------------------------------------------
# Auto Scaling Group
#--------------------------------------------------------------
resource "aws_autoscaling_group" "scaling_group" {
	name                	  = "scaling_group"
	availability_zones  	  = ["${element(split(",", var.azs), count.index)}"]
	min_size            	  = 0
	max_size	   	    	  = 5
	vpc_zone_identifier 	  = ["${element(aws_subnet.private_subnet.*.id, count.index)}"]
	load_balancers      	  = ["${aws_elb.ZeroBalancer.name}"]
	health_check_type         = "EC2"
	health_check_grace_period = 100
	launch_configuration      = "${aws_launch_configuration.scale_config.name}"
	depends_on                = ["aws_internet_gateway.gateway", "aws_db_instance.zero_database"]

	lifecycle {
		create_before_destroy = true
	}
}

#--------------------------------------------------------------
# Auto Scaling Group Policy(ies)
#--------------------------------------------------------------
resource "aws_autoscaling_policy" "scaling_policy" {
	name                   = "scaling_policy"
	scaling_adjustment     = 1
	adjustment_type        = "ChangeInCapacity"
	cooldown               = 300
	autoscaling_group_name = "${aws_autoscaling_group.scaling_group.name}"

	lifecycle {
		create_before_destroy = true
	}
}

#--------------------------------------------------------------
# Cloud-Watch Metric Alarm (triggers scaling policy)
#--------------------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "scaling_alarm" {
	alarm_name          = "scaling_alarm"
	comparison_operator = "GreaterThanOrEqualToThreshold"
	evaluation_periods  = "2"
	metric_name         = "CPUUtilization"
	namespace           = "AWS/EC2"
	period              = 120
	statistic           = "Average"
	threshold           = 80

	dimensions {
		AutoScalingGroupName = "${aws_autoscaling_group.scaling_group.name}"
	}

	alarm_description = "This metric monitors ec2 cpu utilization"
	alarm_actions     = ["${aws_autoscaling_policy.scaling_policy.arn}"]

	lifecycle {
		create_before_destroy = true
	}
}