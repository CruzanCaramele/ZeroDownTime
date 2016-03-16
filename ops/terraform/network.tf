#--------------------------------------------------------------
# VPC Networking
#--------------------------------------------------------------
resource "aws_vpc" "zero_vpc" {
	cidr_block         = "10.0.0.0/16"
	enable_dns_support = true
	enable_hostnames   = true

	tags {
		Name = "zero_vpc"
	}

	lifecycle {
		create_before_destroy = true
	}
}

resource "aws_subnet" "public" {
	vpc_id                  = "${aws_vpc.zero_vpc.id}"
	cidr_block              = "10.0.23.0/24"
	availaibility_zone      = "us-east-1a"
	map_public_ip_on_launch = true 

	tags {
		Name = "zero_public_subnet"
	}

	lifecycle {
		create_before_destroy = true
	}
}

resource "aws_internet_gateway" "gateway" {
	vpc_id = "${aws_vpc.zero_vpc.id}"

	lifecycle {
		create_before_destroy = true
	}
}

resource "aws_route_table" "public" {
	vpc_id = "${aws_vpc.zero_vpc.id}"

	lifecycle {
		create_before_destroy
	}
}

resource "aws_route" "public_internet_gateway" {
	route_table_id         = "${aws_route_table.public.id}"
	destination_cidr_block = "0.0.0.0/0"
	gateway_id			   = "${aws_internet_gateway.gateway.id}"

	lifecycle {
		create_before_destroy = true
	}
}

resource "aws_route_table_association" "public" {
	subnet_id      = "${aws_subnet.public.id}"
	route_table_id = "${aws_route_table.public.id}"

	lifecycle {
		create_before_destroy = true
	}
}

#--------------------------------------------------------------
# elb
#--------------------------------------------------------------
resource "aws_elb" "load_balancer" {
	subnets         = ["${aws_subnet.public.id}"]
	security_groups = ["${aws_security_group.web.id}"]

	listener {
		instance_port     = 80
		instance_protocol = "http"
		lb_port           = 80
		lb_protocol       = "http"
	}

	health_check {
		healthy_threshold 	= 2
		unhealthy_threshold = 2
		timeout 			= 3
		target 				= "HTTP:80/"
		interval 			= 30
	}

	instances = ["${aws_instance.zero-down-time.id}"]

	lifecycle {
		create_before_destroy = true
	}
}
#--------------------------------------------------------------
# proxy protocol policy							
#--------------------------------------------------------------
resource "aws_proxy_protocol_policy" "http" {
	load_balancer  = "${aws_elb.load_balancer.name}"
	instance_ports = ["80"] 

	lifecycle {
		create_before_destroy = true
	}
}