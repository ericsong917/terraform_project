resource "aws_instance" "eric-bastion1" {
    ami= data.aws_ami.eric-nginx.id
    instance_type = "t2.micro"
    subnet_id = aws_subnet.eric-public1.id
    associate_public_ip_address = true
    vpc_security_group_ids = ["${aws_security_group.eric-bastion-sg.id}"]
    key_name = "eric-key"
    tags= {
        Name = "eric-bastion1"
    }
}

