resource "aws_s3_bucket" "eric-website-bucket23123" {
    bucket=var.bucket_name
    acl = "private"
    website{
        index_document="index.html"
        error_document="index.html"
    }
}

resource "aws_s3_bucket" "ericbackends3" {
    bucket=var.s3_bucket
    versioning {
      enabled=true
    }
}
