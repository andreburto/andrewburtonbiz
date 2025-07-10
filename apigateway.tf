resource "aws_api_gateway_rest_api" "cftest" {
  name = "CF Test Backend API"
  description = "CF Test Backend API"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "root" {
  rest_api_id = aws_api_gateway_rest_api.cftest.id
  parent_id = aws_api_gateway_rest_api.cftest.root_resource_id
  path_part = "hello"
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [
    aws_api_gateway_method.proxy,
    aws_api_gateway_method_response.proxy,
    aws_api_gateway_integration.proxy,
    aws_api_gateway_integration_response.proxy,
    aws_api_gateway_method.post,
    aws_api_gateway_method_response.post,
    aws_api_gateway_integration.post,
    aws_api_gateway_integration_response.post,
  ]

  rest_api_id = aws_api_gateway_rest_api.cftest.id
  stage_name = "kirsche"
}

##### GET Image List #####
resource "aws_api_gateway_method" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.cftest.id
  resource_id = aws_api_gateway_resource.root.id
  http_method = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.cftest.id
  resource_id = aws_api_gateway_resource.root.id
  http_method = aws_api_gateway_method.proxy.http_method
  integration_http_method = "POST"
  type = "AWS"
  uri = aws_lambda_function.cftest.invoke_arn
}

resource "aws_api_gateway_method_response" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.cftest.id
  resource_id = aws_api_gateway_resource.root.id
  http_method = aws_api_gateway_method.proxy.http_method

  status_code = "200"

  //cors section
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.cftest.id
  resource_id = aws_api_gateway_resource.root.id
  http_method = aws_api_gateway_method.proxy.http_method
  status_code = aws_api_gateway_method_response.proxy.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,HEAD'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  depends_on = [
    aws_api_gateway_method.proxy,
    aws_api_gateway_integration.proxy
  ]
}

##### POST Tesr #####
resource "aws_api_gateway_resource" "post" {
  rest_api_id = aws_api_gateway_rest_api.cftest.id
  parent_id = aws_api_gateway_rest_api.cftest.root_resource_id
  path_part = "test"
}

resource "aws_api_gateway_method" "post" {
  rest_api_id = aws_api_gateway_rest_api.cftest.id
  resource_id = aws_api_gateway_resource.post.id
  http_method = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "post" {
  rest_api_id = aws_api_gateway_rest_api.cftest.id
  resource_id = aws_api_gateway_resource.post.id
  http_method = aws_api_gateway_method.post.http_method
  integration_http_method = "POST"
  type = "AWS"
  uri = aws_lambda_function.cftest_post.invoke_arn
}

resource "aws_api_gateway_method_response" "post" {
  rest_api_id = aws_api_gateway_rest_api.cftest.id
  resource_id = aws_api_gateway_resource.post.id
  http_method = aws_api_gateway_method.post.http_method

  status_code = "200"
}

resource "aws_api_gateway_integration_response" "post" {
  rest_api_id = aws_api_gateway_rest_api.cftest.id
  resource_id = aws_api_gateway_resource.post.id
  http_method = aws_api_gateway_method.post.http_method
  status_code = aws_api_gateway_method_response.post.status_code

  depends_on = [
    aws_api_gateway_method.post,
    aws_api_gateway_integration.post
  ]
}
