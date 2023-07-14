<<<<<<< HEAD
provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAQGCV7V5G4B5NSRCT"
  secret_key = "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"
=======
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
>>>>>>> fe6204a4eafe8a0b2de6902e62eb82ba00d9d8d0
}