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
resource "aws_route53_record" "db_record" {
	zone_id = "${aws_route53_zone.db_zone.id}"
	name    = "psql.database.com"
	type    = "CNAME"

	records = [
		"${aws_db_instance.zero_database.address}"
	]

	lifecycle {
		create_before_destroy = true
	}
}