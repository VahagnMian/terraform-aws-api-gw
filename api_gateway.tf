resource "aws_api_gateway_rest_api" "api_gw" {
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = var.info_title #Need to export #api_gw
      version = var.info_version #Need to export #1.0
    }
    paths = {
      "/path1" = {
        get = {
          x-amazon-apigateway-integration = {
            httpMethod           = "GET"
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "https://ip-ranges.amazonaws.com/ip-ranges.json"
          }
        }
      }
    }
  })

  name = "api_gw" #Need to export

  endpoint_configuration {
    types = ["REGIONAL"] #Need to export #REGIONAL
  }
}

resource "aws_api_gateway_deployment" "example" {
  rest_api_id = aws_api_gateway_rest_api.api_gw.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.api_gw.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "example" {
  deployment_id = aws_api_gateway_deployment.example.id
  rest_api_id   = aws_api_gateway_rest_api.api_gw.id
  stage_name    = var.stage_name #Need to export #api-stage
}