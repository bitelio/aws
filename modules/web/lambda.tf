data "aws_iam_policy_document" "lambda" {
  statement {
    sid     = "LambdaAssumeRole"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com",
        "edgelambda.amazonaws.com",
      ]
    }
  }
}

resource "aws_iam_role" "lambda" {
  name               = "lambda"
  assume_role_policy = data.aws_iam_policy_document.lambda.json
}

data "archive_file" "lambda_function" {
  type        = "zip"
  source_file = "${path.module}/index.js"
  output_path = "${path.module}/functions/${var.account}_http_headers.zip"
}

resource "aws_lambda_function" "http_headers" {
  provider         = aws.us-east-1
  runtime          = "nodejs10.x"
  filename         = data.archive_file.lambda_function.output_path
  source_code_hash = data.archive_file.lambda_function.output_base64sha256
  function_name    = "http_headers"
  description      = "Add security headers to response"
  handler          = "index.handler"
  role             = aws_iam_role.lambda.arn
  timeout          = 1
  publish          = true
}
