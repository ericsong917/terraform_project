resource "aws_vpc" "eric-vpc" {
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "eric-vpc"
  }
}

resource "aws_subnet" "eric-public1" {
  vpc_id     = aws_vpc.eric-vpc.id
  cidr_block = "10.0.0.0/27"
  map_public_ip_on_launch = true
  availability_zone = "ap-northeast-2a"
  tags = {
    Name = "eric-public1"
  }
}

resource "aws_subnet" "eric-lambda1" {
  vpc_id     = aws_vpc.eric-vpc.id
  cidr_block = "10.0.0.32/27"
  availability_zone = "ap-northeast-2a"
  tags = {
    Name = "eric-lambda1"
  }
}

resource "aws_subnet" "eric-db1" {
  vpc_id     = aws_vpc.eric-vpc.id
  cidr_block = "10.0.0.64/27"
  availability_zone = "ap-northeast-2a"
  tags = {
    Name = "eric-db11"
  }
}

resource "aws_subnet" "eric-public2" {
  vpc_id     = aws_vpc.eric-vpc.id
  cidr_block = "10.0.0.96/27"
  availability_zone = "ap-northeast-2c"
  tags = {
    Name = "eric-public2"
  }
  map_public_ip_on_launch = true
}

resource "aws_subnet" "eric-lambda2" {
  vpc_id     = aws_vpc.eric-vpc.id
  cidr_block = "10.0.0.128/27"
  availability_zone = "ap-northeast-2c"
  tags = {
    Name = "eric-lambda2"
  }
}

resource "aws_subnet" "eric-db2" {
  vpc_id     = aws_vpc.eric-vpc.id
  cidr_block = "10.0.0.160/27"
  availability_zone = "ap-northeast-2c"
  tags = {
    Name = "eric-db2"
  }
}