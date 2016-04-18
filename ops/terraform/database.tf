#--------------------------------------------------------------
# DB-Instance
#--------------------------------------------------------------
resource "aws_db_instance" "zero_database" {
	allocated_storage      = 5
	engine			       = "postgres"
	multi_az			   = true
	engine_version         = "9.4.7"
	instance_class         = "db.t1.micro"
	identifier             = "zerodbinstance"
	name			       = "zeropgdatabase"
	username               = "masterusername"
	password               = "masterpassword"
	port                   = 5432
	vpc_security_group_ids = ["${aws_security_group.web-ssh.id}", "${aws_security_group.consul_security_group.id}",
							  "${aws_security_group.zookeeper_security_group.id}"]
	db_subnet_group_name   = "${aws_db_subnet_group.zero_db_subnet_group.name}"
}

#--------------------------------------------------------------
# DB-Subnet Group
#--------------------------------------------------------------
resource "aws_db_subnet_group" "zero_db_subnet_group" {
	name        = "postgres"
	description = "subnet group for database"
	subnet_ids  = ["${aws_subnet.private_subnet.id}"]
}