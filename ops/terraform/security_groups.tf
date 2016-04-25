#--------------------------------------------------------------
# Security group(s) - default
#--------------------------------------------------------------
resource "aws_security_group" "default" {
    description = "Default security group that allows all traffic"
    vpc_id      = "${aws_vpc.zero_vpc.id}"

    ingress {
        from_port = "0"
        to_port   = "0"
        protocol  = "-1"
        self      = true
    }

    # Allows all inbound traffic
    ingress {
        from_port   = "0"
        to_port     = "0"
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Allows all outbound traffic.
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        }

    tags {
        Name = "zero-default-sg"
    }

    lifecycle{
        create_before_destroy = true
    }
}