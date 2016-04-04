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

variable "public_subnets" {
	description = "public subnets cidrs"
	default     = "10.0.1.0/24,10.0.3.0/24"
}