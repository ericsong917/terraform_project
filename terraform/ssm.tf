resource "aws_ssm_parameter" "rds_ssm"{
    name="eric_rds_password"
    type = "String"
    value = random_password.password.result
}