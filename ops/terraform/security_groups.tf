#--------------------------------------------------------------
# Security group(s)
#--------------------------------------------------------------
resource "aws_security_group" "web" {
	name 		= "web"
	description = "allow access to the web"
	vpc_id 		= "{aws_vpc.zero.id}"

	ingress {
		from_port = 0
		to_port   = 65535
		protocol  = "tcp"
		self      = true
	}

	ingress {
		from_port = 0
		to_port   = 65535
		protocol  = "udp"
		self      = true
	}

	ingress {
		from_port = 22
		to_port   = 22
		protocol  = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
		from_port = 80
		to_port   = 80
		protocol  = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
		from_port = 443
		to_port   = 443
		protocol  = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
		from_port = 1099
		to_port   = 1099
		protocol  = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
		from_port = 8080
		to_port   = 8080
		protocol  = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
		from_port = 0
		to_port   = 0
		protocol  = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

    lifecycle {
        create_before_destroy = true
    }
}