variable "aws_access_key" {
	description = "aws access key , obtain from environment"
	default     = "{{env `AWS_ACCESS_KEY_ID`}}"
}

variable "aws_secret_key" {
	description = "aws secret key , obtain from environment"
	default     = "{{env `AWS_SECRET_ACCESS_KEY`}}"
}

variable "key_name" {
	description = "name of private key"
	default     = "Zero-key"
}

variable "private_key" {
	description = "private key for bastion connections"
	default     = "ssh_keys/Zero-key.pem"
}

variable "private_cidrs" {
	description = "private subnets cidrs for high availability"
	default     = "10.139.1.0/24,10.139.2.0/24"
}

variable "public_cidrs" {
	description = "public subnets cidrs"
	default     = "10.139.101.0/24,10.139.102.0/24"
}

variable "azs" {
	description = "availability for resources"
	default		= "us-east-1a,us-east-1b,us-east-1c"
}