resource "aws_cloudfront_distribution" "s3-distribution"{
  aliases = ["eric.tf-dunn.link"]
  web_acl_id =  "arn:aws:wafv2:us-east-1:151564769076:global/webacl/eric-ACL/0613fb2e-1e2f-4ba7-be4a-aa3f7b206204"
  enabled             = true
  is_ipv6_enabled     = false
  tags={}
  comment             = "Some comment"
  default_root_object = "index.html"
  origin {
    origin_id="eric-website-bucket1231.s3-website.ap-northeast-2.amazonaws.com"
    connection_timeout       = 10
    connection_attempts = 3
    origin_access_control_id = "E2S3O29URKYCH3"
    domain_name="eric-website-bucket1231.s3.ap-northeast-2.amazonaws.com"
  }
  default_cache_behavior {
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    compress               = true
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    viewer_protocol_policy = "redirect-to-https"
    target_origin_id       = "eric-website-bucket1231.s3-website.ap-northeast-2.amazonaws.com"
  }
  restrictions {
     geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }
  viewer_certificate {
    acm_certificate_arn            = "arn:aws:acm:us-east-1:151564769076:certificate/a9a6646f-9d74-40bc-b9be-ca9dabf6d4f9"
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }
     }