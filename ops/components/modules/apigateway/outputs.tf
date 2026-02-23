output "api_base_url" {
  description = "Base URL of the API Gateway"
  value       = aws_api_gateway_stage.stage.invoke_url
}
