resource "aws_s3_bucket" "bitelio" {
  bucket = "bitelio"
  region = "eu-central-1"

  versioning {
    enabled = true
  }

  policy = data.aws_iam_policy_document.bitelio.json
}

data "aws_iam_policy_document" "bitelio" {
  statement {
    sid       = "DenyIncorrectEncryptionHeader"
    effect    = "Deny"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::bitelio/*"]

    principals {
      identifiers = ["*"]
      type        = "*"
    }

    condition {
      test     = "StringNotEquals"
      values   = ["AES256"]
      variable = "s3:x-amz-server-side-encryption"
    }
  }

  statement {
    sid       = "DenyUnEncryptedObjectUploads"
    effect    = "Deny"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::bitelio/*"]

    principals {
      identifiers = ["*"]
      type        = "*"
    }

    condition {
      test     = "Null"
      values   = ["true"]
      variable = "s3:x-amz-server-side-encryption"
    }
  }
}
