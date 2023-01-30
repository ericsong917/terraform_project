resource "aws_security_group" "eric-lambda-sg"{
    name ="eric-lambda-sg"
    vpc_id = aws_vpc.eric-vpc2.id
    ingress{
        from_port = 80
        to_port=80
        protocol="tcp"
        cidr_blocks = ["27.122.140.10/32"]
    }
    egress{
        from_port = 3306
        to_port=3306
        protocol="tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
resource "aws_security_group" "eric-rds-sg"{
    name ="eric-rds-sg"
    vpc_id = aws_vpc.eric-vpc2.id
    ingress{
        from_port = 3306
        to_port=3306
        protocol="tcp"
        security_groups = [aws_security_group.eric-lambda-sg.id]
    }
    egress{
        from_port = 0
        to_port=0
        protocol="tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

