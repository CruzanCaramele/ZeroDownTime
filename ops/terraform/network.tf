#--------------------------------------------------------------
# VPC
#--------------------------------------------------------------
resource "aws_vpc" "zero_vpc" {
	cidr_block             = "10.0.0.0/16"
	enable_dns_support     = true
	enable_dns_hostnames   = true

	tags {
		Name = "zero_vpc"
	}

	lifecycle {
		create_before_destroy = true
	}
}

#--------------------------------------------------------------
# Internet Gateway
#--------------------------------------------------------------
resource "aws_internet_gateway" "gateway" {
	vpc_id = "${aws_vpc.zero_vpc.id}"

	lifecycle {
		create_before_destroy = true
	}
}

#--------------------------------------------------------------
# Public Subnet
#--------------------------------------------------------------
resource "aws_subnet" "public" {
	vpc_id                  = "${aws_vpc.zero_vpc.id}"
	cidr_block              = "10.0.1.0/24"
	availability_zone       = "us-east-1a"
	map_public_ip_on_launch = true 

	tags {
		Name = "zero_public_subnet"
	}

	lifecycle {
		create_before_destroy = true
	}
}

resource "aws_route_table" "public" {
	vpc_id = "${aws_vpc.zero_vpc.id}"

	route {
		cidr_block = "0.0.0.0./0"
		gateway_id = "${aws_internet_gateway.gateway.id}"
	}

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
# ELB Public subnet
#--------------------------------------------------------------
# resource "aws_subnet" "elb_public" {
# 	vpc_id     = "${aws_vpc.zero_vpc.id}"
# 	cidr_block =  "10.0.3.0/24"
# }

# resource ""

#--------------------------------------------------------------
# Private subnet for instances
#--------------------------------------------------------------
resource "aws_subnet" "private_subnet" {
	vpc_id = "${aws_vpc.zero_vpc.id}"
	cidr_block = "10.0.2.0/24"
	availability_zone = "us-east-1a"

	tags {
		Name = "zero_private_subnet"
	}

	lifecycle {
		create_before_destroy = true
	}
}

resource "aws_route_table" "private_subnet_table" {
	vpc_id = "${aws_vpc.zero_vpc.id}"

	route {
		cidr_block = "0.0.0.0/0"
	}

	lifecycle {
		create_before_destroy = true
	}
}

resource "aws_route_table_association" "private_table_association" {
	subnet_id      = "${aws_subnet.private_subnet.id}"
	route_table_id = "${aws_route_table.private_subnet_table.id}"
}


#--------------------------------------------------------------
# elb
#--------------------------------------------------------------
resource "aws_elb" "ZeroBalancer" {
	subnets         = ["${aws_subnet.public.id}"]
	security_groups = ["${aws_security_group.web-ssh.id}"]

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

	connection_draining         = true
	connection_draining_timeout = 300
	cross_zone_load_balancing   = true
	instances                   = ["${aws_instance.zero-down-time.*.id}"]

	lifecycle {
		create_before_destroy = true
	}
}
#--------------------------------------------------------------
# proxy protocol policy							
#--------------------------------------------------------------
# resource "aws_proxy_protocol_policy" "http" {
# 	load_balancer  = "${aws_elb.ZeroBalancer.name}"
# 	instance_ports = ["80"] 

# 	lifecycle {
# 		create_before_destroy = true
# 	}
# }