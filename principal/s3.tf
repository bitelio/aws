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

  statement {
    actions   = ["s3:ListBucket"]
    effect    = "Allow"
    resources = ["arn:aws:s3:::bitelio"]

    principals {
      identifiers = [
        "arn:aws:iam::${var.testing_account_id}:root",
        "arn:aws:iam::${var.production_account_id}:root",
      ]

      type = "AWS"
    }
  }

  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject",
    ]

    effect = "Allow"
    resources = [
      "arn:aws:s3:::bitelio/testing",
    ]

    principals {
      identifiers = [
        "arn:aws:iam::${var.testing_account_id}:root",
        "arn:aws:iam::${var.production_account_id}:root",
      ]
      type        = "AWS"
    }
  }


}
