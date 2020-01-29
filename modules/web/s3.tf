resource "aws_s3_bucket" "web-bucket" {
  bucket = var.domain
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

resource "aws_s3_bucket" "logs" {
  bucket = "logs.${var.domain}"

  lifecycle_rule {
    id      = "logs-expiration"
    prefix  = ""
    enabled = true

    expiration {
      days = 30
    }

    abort_incomplete_multipart_upload_days = 7
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.s3.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
}
