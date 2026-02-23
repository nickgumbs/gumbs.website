output "jokes_table_name" {
  description = "Name of the DynamoDB jokes table"
  value       = aws_dynamodb_table.joke_table.name
}

output "jokes_table_arn" {
  description = "ARN of the DynamoDB jokes table"
  value       = aws_dynamodb_table.joke_table.arn
}

output "visitor_table_name" {
  description = "Name of the DynamoDB visitor table"
  value       = aws_dynamodb_table.visitor_table.name
}

output "visitor_table_arn" {
  description = "ARN of the DynamoDB visitor table"
  value       = aws_dynamodb_table.visitor_table.arn
}
