data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = var.source_dir
  output_path = "${path.module}/generated/${var.function_name}.zip"
}

resource "aws_iam_role" "lambda_exec_role" {
  name = "${var.function_name}-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_policy" {
  name = "${var.function_name}-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = concat(
      [
        {
          Effect = "Allow"
          Action = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ]
          Resource = "arn:aws:logs:*:*:*"
        }
      ],
      length(var.dynamodb_table_arns) > 0 ? [
        {
          Effect = "Allow"
          Action = [
            "dynamodb:GetItem",
            "dynamodb:UpdateItem",
            "dynamodb:DescribeTable"
          ]
          Resource = var.dynamodb_table_arns
        }
      ] : []
    )
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attach" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

resource "aws_lambda_function" "function" {
  filename            = data.archive_file.lambda_zip.output_path
  function_name       = var.function_name
  role                = aws_iam_role.lambda_exec_role.arn
  handler             = var.handler
  source_code_hash    = data.archive_file.lambda_zip.output_base64sha256
  runtime             = var.runtime
  timeout             = 30

  environment {
    variables = var.environment_variables
  }

  tags = {
    Environment = var.environment
  }
}
