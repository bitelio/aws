resource "aws_lambda_function" "http_headers" {
  provider         = aws.us-east-1
  runtime          = "nodejs10.x"
  filename         = "function.zip"
  function_name    = "http_headers"
  description      = "Add security headers to response"
  handler          = "index.handler"
  source_code_hash = filebase64sha256("function.zip")
  role             = aws_iam_role.lambda.arn
  timeout          = 1
  publish          = true
}
