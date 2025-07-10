data "archive_file" "cftest" {
  type = "zip"
  source_file = "index.py"
  output_path = "index.zip"
}

resource "aws_lambda_function" "cftest" {
  function_name = "cftest"
  handler = "index.lambda_handler"
  runtime = "python3.10"
  role = aws_iam_role.lambda.arn
  filename = data.archive_file.cftest.output_path
  source_code_hash = data.archive_file.cftest.output_base64sha256
  timeout = 60
  memory_size = 128

  environment {
    variables = {
      BUCKET_NAME = var.domain_url
      PREFIX = "kirsche"
    }
  }
}

#####
# TEST POST LAMBDA
data "archive_file" "cftest_post" {
  type = "zip"
  source_file = "post.py"
  output_path = "post.zip"
}

resource "aws_lambda_function" "cftest_post" {
  function_name = "cftest_post"
  handler = "post.lambda_handler"
  runtime = "python3.10"
  role = aws_iam_role.lambda.arn
  filename = data.archive_file.cftest_post.output_path
  source_code_hash = data.archive_file.cftest_post.output_base64sha256
  timeout = 60
  memory_size = 128
}
