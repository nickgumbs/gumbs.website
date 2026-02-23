terraform {
  backend "s3" {
    bucket         = "gumbs-tf-state"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "gumbs-tf-state-lock"
    encrypt        = true
  }
}
