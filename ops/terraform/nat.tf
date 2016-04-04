#--------------------------------------------------------------
# NAT Eip
#--------------------------------------------------------------
resource "aws_eip" "nat_eip" {
	vpc   = true
	count = 1

	lifecycle {
		create_before_destroy = true
	}
}

#--------------------------------------------------------------
# NAT Gateway
#--------------------------------------------------------------
resource "aws_nat_gateway" "nat_gateway" {
	count         = 1
	allocation_id = "${aws_eip.nat_eip.id}"
	subnet_id     = "${aws_subnet.public.id}"
	depends_on    = ["aws_internet_gateway.gateway"]

	lifecycle {
		create_before_destroy = true
	}
}