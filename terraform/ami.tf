data "aws_ami" "eric-nginx"{
  filter{
    name = "name"
    values = ["eric-nginx"]
  }
  most_recent= true
}