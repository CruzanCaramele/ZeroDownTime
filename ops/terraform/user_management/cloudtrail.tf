#--------------------------------------------------------------
# Cloudtrail
#--------------------------------------------------------------
resource "aws_cloudtrail" "zeroTrail" {
	name 		   				  = "zeroTrail"
	s3_bucket_name 				  = "${aws_s3_bucket.zero-trail-bucket.id}"
	s3_key_prefix  				  = "/"
	is_multi_region_trail         = true
	include_global_service_events = false 
	sns_topic_name				  = "zeroTrailNotifications"

}

resource "aws_s3_bucket" "zero-trail-bucket" {
	bucket        = "zero-trail-bucket"
	force_destroy = true
	policy        = <<POLICY
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "AWSCloudTrailAclCheck",
			"Effect": "Allow",
			"Principal": {
				"Service": "cloudtrail.amazonaws.com"
			},
			"Action": "s3:GetBucketAcl",
			"Resource": "arn:aws:s3:::zero-trail-bucket"
		},
		{
			"Sid": "AWSCloudTrailWrite20150319",
			"Effect": "Allow",
			"Principal": {
				"Service": "cloudtrail.amazonaws.com"
			},
			"Action": "s3:PutObject",
			"Resource": "arn:aws:s3:::zero-trail-bucket/*",
			"Condition": {
				"StringEquals": {
					"s3:x-amz-acl": "bucket-owner-full-control"
				}
			}
		}
	]
}
POLICY
}