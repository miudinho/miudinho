terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.60.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
  # shared_credentials_file = "C:\Users\user_name\.aws\credentials"
  profile = "aws_terra_acg"
}