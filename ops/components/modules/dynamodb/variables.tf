variable "environment" {
  description = "The environment (e.g., production, staging)"
  type        = string
}

variable "jokes_table_data" {
  description = "DynamoDB Jokes table data"
  type = object({
    name = string
    primary_key = object({
      name = string
      type = string
    })
  })
}

variable "visitor_table_data" {
  description = "DynamoDB Visitor Count table data"
  type = object({
    name = string
    primary_key = object({
      name = string
      type = string
    })
  })
}

