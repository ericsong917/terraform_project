resource "aws_route_table" "publicrt"{
    vpc_id = aws_vpc.eric-vpc.id
    route{
        cidr_block="0.0.0.0/0"
        gateway_id=aws_internet_gateway.igw.id
    }
}
resource "aws_route_table_association" "public_routing" {
  subnet_id      = aws_subnet.eric-public1.id
  route_table_id = aws_route_table.publicrt.id
}

resource "aws_route_table" "privatert"{
    vpc_id = aws_vpc.eric-vpc.id
    route{
        cidr_block="0.0.0.0/0"
        gateway_id=aws_nat_gateway.nat.id
    }
}
resource "aws_route_table_association" "private_routing1" {
  subnet_id     = aws_subnet.eric-db1.id
  route_table_id = aws_route_table.privatert.id
}
resource "aws_route_table_association" "private_routing2" {
  subnet_id     = aws_subnet.eric-db2.id
  route_table_id = aws_route_table.privatert.id
}
resource "aws_route_table_association" "private_routing3" {
  subnet_id     = aws_subnet.eric-lambda1.id
  route_table_id = aws_route_table.privatert.id
}
resource "aws_route_table_association" "private_routing4" {
  subnet_id     = aws_subnet.eric-lambda2.id
  route_table_id = aws_route_table.privatert.id
}