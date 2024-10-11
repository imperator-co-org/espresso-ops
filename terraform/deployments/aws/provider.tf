provider "aws" {
  region = "ap-south-1"
}

terraform {
  required_version = ">= 1.4.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.68.0"
    }
  }
  backend "s3" {
    bucket = PUT_YOUR_BUCKET_NAME_HERE
    key    = "tfstate"
    region = "ap-south-1"
  }
}
