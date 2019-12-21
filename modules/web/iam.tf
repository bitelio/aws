data "aws_iam_policy_document" "cd_web" {
  statement {
    effect = "Allow"
    actions = [
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:PutObject",
    ]
    resources = ["${aws_s3_bucket.web-bucket.arn}/*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket",
    ]
    resources = [aws_s3_bucket.web-bucket.arn]
  }
}

data "aws_iam_policy_document" "assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["arn:aws:iam::${var.principal}:root"]
      type        = "AWS"
    }
  }
}

resource "aws_iam_role" "cd_web" {
  name               = "cd_web"
  assume_role_policy = data.aws_iam_policy_document.assume.json
}

resource "aws_iam_role_policy" "cd_web" {
  name   = "cd_web"
  role   = aws_iam_role.cd_web.id
  policy = data.aws_iam_policy_document.cd_web.json
}
