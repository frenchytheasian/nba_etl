terraform {

  backend "s3" {
    bucket = "terraform-state-753807855780"
    key    = "nba-etl/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}


