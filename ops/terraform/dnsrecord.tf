#--------------------------------------------------------------
# Route53 Zone for db-instance
#--------------------------------------------------------------
resource "aws_route53_zone" "db_zone" {
	name   = "database.com"
	vpc_id = "${aws_vpc.zero_vpc.id}" 

	lifecycle {
		create_before_destroy = true
	}
}

#--------------------------------------------------------------
# Route53 Record for db-instance
#--------------------------------------------------------------
resource "aws_route53_record" "www" {
	zone_id = "{aws_route53_zone.primary.zone_id}"
	name    = "example.com"
	type    = "A"

	alias {
		name    			   = "${aws_elb.ZeroBalancer.dns_name}"
		zone_id 			   = "${aws_elb.ZeroBalancer.zone_id}"
		evaluate_target_health = true
	}

	lifecycle {
		create_before_destroy = true
	}
}