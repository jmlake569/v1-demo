# main.tf
terraform {
  required_version = ">= 0.14.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.45.0"
    }
  }
}

provider "aws" {
  region = var.region
}