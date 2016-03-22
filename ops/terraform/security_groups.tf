#--------------------------------------------------------------
# Security group(s)
#--------------------------------------------------------------
resource "aws_security_group" "default" {
	name        = "default-zero"
	description = "Default security group that allows inbound and outbound traffic from all instances in the VPC"
	vpc_id	    = "{aws_vpc.zero.id}"

	ingress {
		from_port = 0
		to_port   = 0
		protocol  = -1
		self      = true
	}

	egress {
		from_port   = 0
		to_port     = 0
		protocol    = -1
		self        = true
		cidr_blocks = ["0.0.0.0/0"]
	}

	lifecycle {
		create_before_destroy = true
	}
}

resource "aws_security_group" "web-ssh" {
	name 		= "web-ssh"
	description = "allow access to the web and ssh"
	vpc_id 		= "{aws_vpc.zero.id}"

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

    lifecycle {
        create_before_destroy = true
    }
}