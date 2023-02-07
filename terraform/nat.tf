resource "aws_eip" "eip"{
    vpc=true
    lifecycle{
        create_before_destroy=true
    }
}
resource "aws_nat_gateway" "nat"{
    allocation_id=aws_eip.eip.id
    subnet_id = aws_subnet.eric-public1.id
    tags = {
        Name="eric-nat-gw-1"
    }
}