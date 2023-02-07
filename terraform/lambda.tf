resource "aws_lambda_function" "lambda"{
    function_name = "eric_lambda"
    filename = "./lambda/lambda_function.zip"
    handler = "lambda_function.lambda_handler"
    runtime="python3.9"
    role = "${aws_iam_role.iam_for_lambda.arn}"
    environment {
    variables = {
      "DB_USERNAME" = var.db_username,
      "IP_RANGE"=var.db_iprange,
      "DB_HOST"=var.db_host,
      "DB_PASSWORD" = random_password.password.result,
      "DB_PORT"=3306,
      "DB_NAME"=var.db_name
    }
  }
    vpc_config {
    subnet_ids =  [aws_subnet.eric-lambda1.id,aws_subnet.eric-lambda2.id]
    security_group_ids = [aws_security_group.eric-lambda-sg.id]
  }
}

resource "aws_lambda_function_url" "lambda_function" {
  function_name = aws_lambda_function.lambda.function_name
  authorization_type = "NONE"
  cors {
    allow_credentials = true
    allow_origins     = ["*"]
    allow_methods     = ["*"]
    allow_headers     = ["date", "keep-alive"]
    expose_headers    = ["keep-alive", "date"]
    max_age           = 86400
  }
}


resource "aws_lambda_function" "lambda2"{
    function_name = "eric_lambda2"
    filename = "./lambda2/lambda_function2.zip"
    handler = "lambda_function2.lambda_handler"
    runtime="python3.9"
    role = "${aws_iam_role.iam_for_lambda.arn}"
    environment {
    variables = {
      "DB_USERNAME" = var.db_username,
      "IP_RANGE"=var.db_iprange,
      "DB_HOST"=var.db_host,
      "DB_PASSWORD" = random_password.password.result,
      "DB_PORT"=3306,
      "DB_NAME"=var.db_name
    }
  }
    vpc_config {
    subnet_ids =  [aws_subnet.eric-lambda1.id,aws_subnet.eric-lambda2.id]
    security_group_ids = [aws_security_group.eric-lambda-sg.id]
  }
}

resource "aws_lambda_function_url" "lambda_function2" {
  function_name = aws_lambda_function.lambda2.function_name
  authorization_type = "NONE"
  cors {
    allow_credentials = true
    allow_origins     = ["*"]
    allow_methods     = ["*"]
    allow_headers     = ["date", "keep-alive"]
    expose_headers    = ["keep-alive", "date"]
    max_age           = 86400
  }
}