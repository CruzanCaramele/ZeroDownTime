variable "aws_access_key" {
	description = "aws access key , obtain from environment"
	default     = "{{env `AWS_ACCESS_KEY_ID`}}"
}

variable "aws_secret_key" {
	description = "aws secret key , obtain from environment"
	default     = "{{env `AWS_SECRET_ACCESS_KEY`}}"
}