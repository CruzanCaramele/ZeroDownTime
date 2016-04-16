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
	bucket = 
}