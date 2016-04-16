#--------------------------------------------------------------
# Cloudtrail
#--------------------------------------------------------------
resource "aws_cloudtrail" "zeroTrail" {
	name 		   				  = "zeroTrail"
	s3_bucket_name 				  = "${aws_s3_bucket.zeroTrailBucket.id}"
	s3_key_prefix  				  = "/prefix"
	include_global_service_events = false 
}