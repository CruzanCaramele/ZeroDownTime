#--------------------------------------------------------------
# Security group(s) - Web
#--------------------------------------------------------------
resource "aws_security_group" "web-ssh" {
	description = "allow access to the web and ssh"
	vpc_id 		= "${aws_vpc.zero_vpc.id}"

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
		from_port   = 0
		to_port     = 0
		protocol    = -1
		cidr_blocks = ["0.0.0.0/0"]
	}

    lifecycle {
        create_before_destroy = true
    }
}

#--------------------------------------------------------------
# Security group - Consul
#--------------------------------------------------------------
resource "aws_security_group" "consul_security_group" {
    description = "Security Group for consul"
    vpc_id = "${aws_vpc.zero_vpc.id}"

    // allows traffic from the SG itself for tcp
    ingress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        self = true
    }

    // allows traffic from the SG itself for udp
    ingress {
        from_port = 0
        to_port = 65535
        protocol = "udp"
        self = true
    }

    // allow traffic for TCP 22 (SSH)
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.source_cidr_block}"]
    }

    // allow traffic for TCP 8300 (Server RPC)
    ingress {
        from_port = 8300
        to_port = 8300
        protocol = "tcp"
        cidr_blocks = ["${var.source_cidr_block}"]
    }

    // allow traffic for TCP 8301 (Serf LAN)
    ingress {
        from_port = 8301
        to_port = 8301
        protocol = "tcp"
        cidr_blocks = ["${var.source_cidr_block}"]
    }

    // allow traffic for UDP 8301 (Serf LAN)
    ingress {
        from_port = 8301
        to_port = 8301
        protocol = "udp"
        cidr_blocks = ["${var.source_cidr_block}"]
    }

    // allow traffic for TCP 8400 (Consul RPC)
    ingress {
        from_port = 8400
        to_port = 8400
        protocol = "tcp"
        cidr_blocks = ["${var.source_cidr_block}"]
    }

    // allow traffic for TCP 8500 (Consul Web UI)
    ingress {
        from_port = 8500
        to_port = 8500
        protocol = "tcp"
        cidr_blocks = ["${var.source_cidr_block}"]
    }

    // allow traffic for TCP 8600 (Consul DNS Interface)
    ingress {
        from_port = 8600
        to_port = 8600
        protocol = "tcp"
        cidr_blocks = ["${var.source_cidr_block}"]
    }

    // allow traffic for UDP 8600 (Consul DNS Interface)
    ingress {
        from_port = 8600
        to_port = 8600
        protocol = "udp"
        cidr_blocks = ["${var.source_cidr_block}"]
    }
}