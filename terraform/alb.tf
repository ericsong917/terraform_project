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
 
# resource "aws_lb_listener" "lb_listener2"{
#     load_balancer_arn = aws_lb.eric-jenkins-lb.arn
#     port ="80"
#     protocol = "HTTP"
#     default_action{
#         type = "forward"
#         target_group_arn = aws_lb_target_group.eric-jenkins-tg.id
#     }
# }
resource "aws_lb_target_group" "eric-jenkins-tg" {
  name     = "eric-jenkins-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.eric-vpc.id
}
 
resource "aws_lb_target_group_attachment" "lb_attach1" {
  target_group_arn = "arn:aws:elasticloadbalancing:ap-northeast-2:151564769076:targetgroup/eric-jenkins-tg/ee331e9b59919e2b"
  target_id = aws_instance.eric-jenkins.id
  port     = 9090
   
}