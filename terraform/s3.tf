resource "aws_s3_bucket" "eric-website-bucket23123" {
    bucket=var.bucket_name
    acl = "private"
    website{
        index_document="index.html"
        error_document="index.html"
    }
}
