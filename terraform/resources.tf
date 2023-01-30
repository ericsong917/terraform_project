resource "aws_s3_bucket" "eric-website-bucket23123" {
    bucket=var.bucket_name
    acl = "public-read"
    website{
        index_document="index.html"
        error_document="index.html"
    }
}

resource "aws_vpc" "eric-vpc2"{
    cidr_block = "10.0.0.0/24"
    tags = {
        Name = "eric-vpc2"
    }
}

resource "aws_subnet" "eric-subnet"{
    vpc_id = aws_vpc.eric-vpc2.id
    cidr_block = "10.0.0.0/26"
}

resource "aws_db_instance" "rds" {
  allocated_storage    = 20
  identifier = "rds-terraform"
  db_name              = "eric-db"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  username             = var.db_name
  password             = var.db_passwd
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_subnet.eric-subnet.id
  tags={
    Name ="eric-rds"
  }
}

resource "aws_lambda_function" "lambda"{
    function_name = temp
    filename = "./lambda/lambda.zip"
    handler = "handler"
    role = aws_iam_role.lambda.arn
}