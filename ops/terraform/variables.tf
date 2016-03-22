variable "aws_access_key" {
	default = "{{env `AWS_ACCESS_KEY_ID`}}"
}

variable "aws_secret_key" {
	default = "{{env `AWS_SECRET_ACCESS_KEY`}}"
}

variable "key_name" {
	default = "Zero-key"
}