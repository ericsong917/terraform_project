resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.eric-vpc.id

  tags = {
    Name = "main"
  }
}
