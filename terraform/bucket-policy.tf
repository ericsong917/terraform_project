resource "aws_s3_bucket_policy" "eric-bucket-policy" {
  bucket = aws_s3_bucket.eric-website-bucket23123.id
  policy= <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect" : "Deny",
            "Sid":"IPAllow",
            "Principal":"*",
            "Action":"S3:*",
            "Resource":"arn:aws:s3:::${var.bucket_name}/*",
            "Condition":{
                "NotIpAddress":{"aws:SourceIp":"27.122.140.10"}
            }
        }
    ]
}
EOF
  }