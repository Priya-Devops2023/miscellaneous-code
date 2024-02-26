terraform {
  backend "s3"
  {
    bucket = "d77-terraform1"
    key    = "misc-code/sonarqube/terraform.tfstate"
    region = "us-east-1"
  }
}
