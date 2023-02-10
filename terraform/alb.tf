resource "aws_lb" "eric-jenkins-lb" {
  name               = "eric-jenkins-lb"
  internal           = false
  ip_address_type = "ipv4"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.eric-lb2-sg.id]
  subnets            = [aws_subnet.eric-public1.id,aws_subnet.eric-public2.id]
  tags = {
    Environment = "eric-jenkins-lb"
  }
}
resource "aws_lb_target_group" "eric-jenkins-tg" {
  name     = "eric-jenkins-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.eric-vpc.id
}
 
resource "aws_lb_target_group_attachment" "lb_attach1" {
  target_group_arn = aws_lb_target_group.eric-jenkins-tg.arn
  target_id = aws_instance.eric-jenkins.id
  port     = 9090
   
}

resource "aws_lb" "eric-lambda-lb"{
    name="eric-lambda-lb"
    
    
}

resource "aws_lb_target_group" "eric-lambda-tg"{
    name="eric-lambda-tg"
    target_type="lambda"
    ip_address_type = "ipv4"
    proxy_protocol_v2                  = false
    slow_start                         = 0
    tags                               = {}
}

resource "aws_lb_target_group_attachment" "lb_attach2"{ 
  target_group_arn = aws_lb_target_group.eric-lambda-tg.arn
  target_id = aws_lambda_function.lambda.arn

}