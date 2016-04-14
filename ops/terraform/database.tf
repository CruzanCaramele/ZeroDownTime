resource "aws_db_instance" "zero_database" {
	allocated_storage    = 10
	engine			     = "postgres"
	engine_version       = "9.4.4"
	instance_class       = "db.t1.micro"
	name			     = "zerodb"
	username             = "myusername"
	password             = "mypassword"
	db_subnet_group_name = "my_database_subent_group"
	parameter_group_name = "default.postgres9.4"
}