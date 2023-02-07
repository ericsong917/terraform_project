resource "aws_db_subnet_group" "eric-rds-subnetgroup" {
  name       = "eric-rds-subnetgroup"
  subnet_ids = [aws_subnet.eric-db1.id,aws_subnet.eric-db2.id]

  tags = {
    Name = "eric-rds-subnetgroup"
  }
}
resource "random_password" "password" {
  length = 16
  special = true
  override_special = "_%@"
}
resource "aws_db_instance" "rds" {
  allocated_storage    = 20
  identifier = "rds-terraform"
  db_name              = "ericdb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  username             = var.db_username
  password             = random_password.password.result
  parameter_group_name = "eric"
  availability_zone = "ap-northeast-2a"
  db_subnet_group_name = "${aws_db_subnet_group.eric-rds-subnetgroup.id}"
  vpc_security_group_ids = [aws_security_group.eric-rds-sg.id]
  skip_final_snapshot  = true
  publicly_accessible = false
  tags={
    Name ="eric-rds"
  }
}