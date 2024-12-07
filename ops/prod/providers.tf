provider "aws" {
  region = "us-east-1"
}

provider "random" {}

terraform {
  required_providers {
    aws = {
      version = "~> 5.78.0"
    }
    random = {
      version = "~> 3.6.3"
    }
  }
}
