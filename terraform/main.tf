terraform {

  backend "s3" {
    bucket         = "terraform-state-753807855780"
    key            = "nba-etl/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Owner      = "Michael French"
      Project    = "NBA ETL"
      Repository = "https://github.com/frenchytheasian/nba_etl"
    }
  }
}


