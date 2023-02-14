resource "aws_security_group" "eric-lambda-sg"{
    name ="eric-lambda-sg"
    vpc_id = aws_vpc.eric-vpc.id
    egress{
        from_port =0
        to_port=65535
        protocol="tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
resource "aws_security_group" "eric-bastion-sg"{
    name ="eric-bastion-sg"
    vpc_id = aws_vpc.eric-vpc.id
    ingress{
        from_port =22
        to_port=22
        protocol="tcp"
        cidr_blocks = ["27.122.140.10/32"]
    }
    egress{
        from_port = 0
        to_port=65535
        protocol="tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
resource "aws_security_group" "eric-rds-sg"{
    name ="eric-rds-sg"
    vpc_id = aws_vpc.eric-vpc.id
    ingress{
        from_port = 3306
        to_port=3306
        protocol="tcp"
        security_groups = [aws_security_group.eric-lambda-sg.id]
    }
    ingress{
        from_port = 3306
        to_port=3306
        protocol="tcp"
        security_groups = [aws_security_group.eric-bastion-sg.id]
    }
    egress{
        from_port = 0
        to_port=65535
        protocol="tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "eric-jenkins-sg"{
    name ="eric-jenkins-sg"
    vpc_id = aws_vpc.eric-vpc.id
    ingress{
        from_port=22
        to_port=22
        protocol="tcp"
        security_groups = [aws_security_group.eric-bastion-sg.id]
    }
    ingress{
        from_port=9090
        to_port=9090
        protocol="tcp"
        security_groups = [aws_security_group.eric-lb2-sg.id]
    }
    egress{
        from_port =0
        to_port=65535
        protocol="tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "eric-lb2-sg"{
    name="eric-lb2-sg"
    vpc_id = aws_vpc.eric-vpc.id
    ingress{
        from_port =80
        to_port=80
        protocol="tcp"
        cidr_blocks = ["27.122.140.10/32","192.30.252.0/22","185.199.108.0/22","140.82.112.0/20","143.55.64.0/20"]
    }
    egress{
        from_port =0
        to_port=65535
        protocol="tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

}