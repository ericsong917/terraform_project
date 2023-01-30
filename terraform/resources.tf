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
    tags = {
        Name = "eric-subnet"
    }
    availability_zone="ap-northeast-2a"
}
resource "aws_subnet" "eric-subnet2"{
    vpc_id = aws_vpc.eric-vpc2.id
    cidr_block = "10.0.0.64/26"
    tags = {
        Name = "eric-subnet2"
    }
    availability_zone="ap-northeast-2c"
}
resource "aws_db_subnet_group" "eric-rds-subnetgroup" {
  name       = "eric-rds-subnetgroup"
  subnet_ids = [aws_subnet.eric-subnet.id,aws_subnet.eric-subnet2.id]

  tags = {
    Name = "eric-rds-subnetgroup"
  }
}
resource "aws_db_instance" "rds" {
  allocated_storage    = 20
  identifier = "rds-terraform"
  db_name              = "ericdb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  username             = var.db_name
  password             = var.db_passwd
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name = "${aws_db_subnet_group.eric-rds-subnetgroup.id}"
  vpc_security_group_ids = [aws_security_group.eric-rds-sg.id]
  skip_final_snapshot  = true
  tags={
    Name ="eric-rds"
  }
}
resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
resource "aws_iam_role_policy_attachment" "AWSLambdaVPCAccessExecutionRole" {
    role       = aws_iam_role.iam_for_lambda.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}
resource "aws_lambda_function" "lambda"{
    function_name = "eric_lambda"
    filename = "./lambda/eric_lambda.zip"
    handler = "eric_lambda.lambda_handler"
    runtime="python3.9"
    role = "${aws_iam_role.iam_for_lambda.arn}"
    vpc_config {
    subnet_ids =  [aws_subnet.eric-subnet.id,aws_subnet.eric-subnet2.id]
    security_group_ids = [aws_security_group.eric-lambda-sg.id]
  }
}