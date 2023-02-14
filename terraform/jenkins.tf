resource "aws_instance" "eric-jenkins" {
    ami= data.aws_ami.eric-nginx.id
    instance_type = "t2.medium"
    subnet_id = aws_subnet.eric-lambda1.id
    vpc_security_group_ids = ["${aws_security_group.eric-jenkins-sg.id}"]
    key_name = "eric-key"
    tags= {
        Name = "eric-jenkins"
    }
}
