#--------------------------------------------------------------
# Route53 Zone
#--------------------------------------------------------------
resource "aws_route53_zone" "primary" {
	name = "example.com"

	lifecycle {
		create_before_destroy = true
	}
}

#--------------------------------------------------------------
# Route53 Record
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