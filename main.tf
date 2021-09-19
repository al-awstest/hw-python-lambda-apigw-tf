terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region = var.aws_region
}

module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = var.lambda_name
  description   = var.lambda_description
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime

  source_path = var.lambda_src

  create_current_version_allowed_triggers = false
  cloudwatch_logs_retention_in_days       = 30

  allowed_triggers = {
    APIGateway = {
      service    = "apigateway"
      source_arn = "${module.api_gateway.apigatewayv2_api_execution_arn}/*/*"
    }
  }

  tags = {
    Name = var.lambda_name
  }
}

module "api_gateway" {
  source = "terraform-aws-modules/apigateway-v2/aws"

  name          = var.apigw_name
  description   = var.apigw_desc
  protocol_type = "HTTP"

  cors_configuration = {
    allow_headers = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token", "x-amz-user-agent"]
    allow_methods = ["GET"]
    allow_origins = ["*"]
  }

  create_api_domain_name = false # to control creation of API Gateway Domain Name
  create_vpc_link        = false # to control creation of VPC link

  # Access logs
  default_stage_access_log_destination_arn = aws_cloudwatch_log_group.api_gw.arn
  default_stage_access_log_format          = "$context.identity.sourceIp - - [$context.requestTime] \"$context.httpMethod $context.routeKey $context.protocol\" $context.status $context.responseLength $context.requestId $context.integrationErrorMessage"

  # Routes and integrations
  integrations = {
    "GET /" = {
      lambda_arn             = module.lambda_function.lambda_function_arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 5000
    }
  }

  tags = {
    Name = var.apigw_name
  }
}

# log group for api_gw access logs
resource "aws_cloudwatch_log_group" "api_gw" {
  name = "/aws/api_gw/${var.apigw_name}"

  retention_in_days = 30
}