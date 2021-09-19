# Output value definitions

output "base_url" {
  description = "Base URL for API Gateway stage."

  value = module.api_gateway.default_apigatewayv2_stage_invoke_url
}