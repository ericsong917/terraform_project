resource "aws_s3_bucket_policy" "eric-bucket-policy" {
  bucket = aws_s3_bucket.eric-website-bucket23123.id
  policy= <<EOF
{
    "Version": "2008-10-17",
    "Id": "PolicyForCloudFrontPrivateContent",
    "Statement": [
        {
            "Sid": "AllowCloudFrontServicePrincipal",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudfront.amazonaws.com"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::eric-website-bucket1231/*",
            "Condition": {
                "StringEquals": {
                    "AWS:SourceArn": "arn:aws:cloudfront::151564769076:distribution/E2TKCJR2BV15LJ"
                }
            }
        }
    ]
}
EOF
  }