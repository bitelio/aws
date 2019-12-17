data "aws_iam_policy_document" "s3" {
  statement {
    sid       = "PublicReadGetObject"
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${var.domain}/*"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket" "web-bucket" {
  bucket = "${var.domain}"
  region = "eu-central-1"
  policy = data.aws_iam_policy_document.s3.json

  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket" "www-web-bucket" {
  bucket = "www.${var.domain}"

  website {
    redirect_all_requests_to = "https://${var.domain}"
  }
}
