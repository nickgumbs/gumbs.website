variable "api_name" {
  description = "Name of the API Gateway"
  type        = string
}

variable "environment" {
  description = "Environment name (prod, staging, etc.)"
  type        = string
}

variable "lambda_invoke_arn" {
  description = "ARN of the Lambda function for invocation"
  type        = string
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
}
