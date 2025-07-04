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

  environment {
    variables = {
      BUCKET_NAME = var.domain_url
      PREFIX = "kirsche"
    }
  }
}
