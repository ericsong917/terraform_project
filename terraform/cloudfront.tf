resource "aws_cloudfront_distribution" "s3_distribution"{
  origin {
    domain_name              = "https://d1ju4d5pioemg3.cloudfront.net"
    origin_access_control_id = "E2S3O29URKYCH3"
    origin_id                = local.s3_origin_id
  }    
}