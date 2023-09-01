terraform {
  required_version = ">= 0.14.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.45.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.1.0"
    }
    null = {
      source = "hashicorp/null"
      version = "3.1.0"
    }
  }
}

provider "aws" {
  region = var.region
}
resource "random_string" "suffix" {
  length  = 5
  special = false
}