terraform {
  backend "s3"{
  bucket="ericbackends3"
  key= "terraform.tfstate"
  region ="ap-northeast-2"
  dynamodb_table = "ericbackends3"
  encrypt = true
}
}
