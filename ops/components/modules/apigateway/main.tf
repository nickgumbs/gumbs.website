resource "aws_api_gateway_rest_api" "api" {
  name        = var.api_name
  description = "API Gateway for ${var.api_name}"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

# /jokes resource
resource "aws_api_gateway_resource" "jokes" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "jokes"
}

# /jokes GET method
resource "aws_api_gateway_method" "jokes_get" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.jokes.id
  http_method      = "GET"
  authorization    = "NONE"
}

resource "aws_api_gateway_integration" "jokes_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.jokes.id
  http_method             = aws_api_gateway_method.jokes_get.http_method
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = var.lambda_invoke_arn
}

# /jokes OPTIONS method (CORS preflight)
resource "aws_api_gateway_method" "jokes_options" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.jokes.id
  http_method      = "OPTIONS"
  authorization    = "NONE"
}

resource "aws_api_gateway_integration" "jokes_options_integration" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.jokes.id
  http_method      = aws_api_gateway_method.jokes_options.http_method
  type             = "MOCK"
  request_templates = {
    "application/json" = jsonencode({ statusCode = 200 })
  }
}

resource "aws_api_gateway_integration_response" "jokes_options_response" {
  rest_api_id       = aws_api_gateway_rest_api.api.id
  resource_id       = aws_api_gateway_resource.jokes.id
  http_method       = aws_api_gateway_method.jokes_options.http_method
  status_code       = "200"
  response_templates = {
    "application/json" = ""
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'*'"
    "method.response.header.Access-Control-Allow-Methods" = "'*'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  depends_on = [
    aws_api_gateway_integration.jokes_options_integration,
    aws_api_gateway_method_response.jokes_options_response
  ]
}

resource "aws_api_gateway_method_response" "jokes_options_response" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.jokes.id
  http_method      = aws_api_gateway_method.jokes_options.http_method
  status_code      = "200"
  response_models  = { "application/json" = "Empty" }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

# /visit resource
resource "aws_api_gateway_resource" "visit" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "visit"
}

# /visit GET method
resource "aws_api_gateway_method" "visit_get" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.visit.id
  http_method      = "GET"
  authorization    = "NONE"
}

resource "aws_api_gateway_integration" "visit_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.visit.id
  http_method             = aws_api_gateway_method.visit_get.http_method
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = var.lambda_invoke_arn
}

# /visit OPTIONS method (CORS preflight)
resource "aws_api_gateway_method" "visit_options" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.visit.id
  http_method      = "OPTIONS"
  authorization    = "NONE"
}

resource "aws_api_gateway_integration" "visit_options_integration" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.visit.id
  http_method      = aws_api_gateway_method.visit_options.http_method
  type             = "MOCK"
  request_templates = {
    "application/json" = jsonencode({ statusCode = 200 })
  }
}

resource "aws_api_gateway_integration_response" "visit_options_response" {
  rest_api_id       = aws_api_gateway_rest_api.api.id
  resource_id       = aws_api_gateway_resource.visit.id
  http_method       = aws_api_gateway_method.visit_options.http_method
  status_code       = "200"
  response_templates = {
    "application/json" = ""
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'*'"
    "method.response.header.Access-Control-Allow-Methods" = "'*'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  depends_on = [
    aws_api_gateway_integration.visit_options_integration,
    aws_api_gateway_method_response.visit_options_response
  ]
}

resource "aws_api_gateway_method_response" "visit_options_response" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.visit.id
  http_method      = aws_api_gateway_method.visit_options.http_method
  status_code      = "200"
  response_models  = { "application/json" = "Empty" }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

# Lambda permission for API Gateway
resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}

# Deployment
resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  depends_on = [
    aws_api_gateway_integration.jokes_integration,
    aws_api_gateway_integration.jokes_options_integration,
    aws_api_gateway_integration.visit_integration,
    aws_api_gateway_integration.visit_options_integration
  ]

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_method.jokes_get.id,
      aws_api_gateway_method.jokes_options.id,
      aws_api_gateway_method.visit_get.id,
      aws_api_gateway_method.visit_options.id,
      aws_api_gateway_integration.jokes_integration.id,
      aws_api_gateway_integration.jokes_options_integration.id,
      aws_api_gateway_integration.visit_integration.id,
      aws_api_gateway_integration.visit_options_integration.id
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Stage
resource "aws_api_gateway_stage" "stage" {
  deployment_id = aws_api_gateway_deployment.deployment.id
  rest_api_id   = aws_api_gateway_rest_api.api.id
  stage_name    = var.environment
}
