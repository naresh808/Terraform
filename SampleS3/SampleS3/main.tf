terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.63.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "ap-south-1"
}

# Resource for S3
resource "aws_s3_bucket" "challa" {
    bucket = "challa-adi"
  
}

