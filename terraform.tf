terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.2.0"
    }
  }

  backend "s3" {
    bucket         = "my-unique-state-bucket-masoom-2025"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "mydynamodbtable"
  }
}