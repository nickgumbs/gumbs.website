variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "handler" {
  description = "Lambda handler entrypoint"
  type        = string
  default     = "app.lambda_handler"
}

variable "source_dir" {
  description = "Path to Lambda source directory"
  type        = string
}

variable "runtime" {
  description = "Lambda runtime"
  type        = string
  default     = "python3.12"
}

variable "environment_variables" {
  description = "Environment variables for Lambda function"
  type        = map(string)
  default     = {}
}

variable "dynamodb_table_arns" {
  description = "List of DynamoDB table ARNs for IAM policy"
  type        = list(string)
  default     = []
}

variable "environment" {
  description = "Environment name (prod, staging, etc.)"
  type        = string
}
