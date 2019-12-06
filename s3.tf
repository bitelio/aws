data "aws_iam_policy_document" "s3" {
  statement {
    sid       = "PublicReadGetObject"
    actions   = ["s3:GetObject"]
    resources  = ["arn:aws:s3:::bitelio.com/*"]
  }
}

resource "aws_s3_bucket" "bitelio-com" {
  bucket = "bitelio.com"
  region = "eu-central-1"
  policy = data.aws_iam_policy_document.s3.json

  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket" "www-bitelio-com" {
  bucket = "www.bitelio.com"

  website {
    redirect_all_requests_to = "https://bitelio.com"
  }
}
