#--------------------------------------------------------------
# NAT Eip
#--------------------------------------------------------------
resource "aws_eip" "nat_eip" {
	vpc   = true

	lifecycle {
		create_before_destroy = true
	}
}

#--------------------------------------------------------------
# NAT Gateway
#--------------------------------------------------------------
resource "aws_nat_gateway" "nat_gateway" {
	allocation_id = "${element(aws_eip.nat_eip.*.id, count.index)}"
	subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"
	depends_on    = ["aws_internet_gateway.gateway"]

	lifecycle {
		create_before_destroy = true
	}
}