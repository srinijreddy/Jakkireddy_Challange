provider "aws" {
  region  = var.region
}

terraform {

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.35.0"
    }
  }

  backend "s3" {}
}