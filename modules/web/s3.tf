resource "aws_s3_bucket" "web-bucket" {
  bucket = "${var.domain}"
  region = "eu-central-1"

  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket" "redirect" {
  bucket = "www.${var.domain}"

  website {
    redirect_all_requests_to = "https://${var.domain}"
  }
}
