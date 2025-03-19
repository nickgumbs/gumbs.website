resource "aws_dynamodb_table" "joke_table" {
  name           = var.jokes_table_data.name
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = var.jokes_table_data.primary_key.name

  attribute {
    name = var.jokes_table_data.primary_key.name
    type = var.jokes_table_data.primary_key.type
  }

  tags = {
    Environment = var.environment
  }
}

resource "aws_dynamodb_table" "visitor_table" {
  name           = var.visitor_table_data.name
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = var.visitor_table_data.primary_key.name

  attribute {
    name = var.visitor_table_data.primary_key.name
    type = var.visitor_table_data.primary_key.type
  }

  tags = {
    Environment = var.environment
  }
}

