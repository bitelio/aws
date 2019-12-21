resource "aws_iam_account_alias" "alias" {
  account_alias = "bitelio"
}

resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length        = 14
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
  allow_users_to_change_password = true
  password_reuse_prevention      = 24
  max_password_age               = 90
}

resource "aws_iam_user" "github" {
  name = "github"
}

resource "aws_iam_group" "deployers" {
  name = "deployers"
}

resource "aws_iam_group_membership" "deployers" {
  name  = "deployers"
  group = aws_iam_group.deployers.name
  users = [aws_iam_user.github.name]
}

resource "aws_iam_group_policy" "deployer" {
  name   = "deployer"
  group  = aws_iam_group.deployers.id
  policy = data.aws_iam_policy_document.deployer.json
}

data "aws_iam_policy_document" "deployer" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    resources = [
      "arn:aws:iam::${var.production_account_id}:role/cd_*",
      "arn:aws:iam::${var.testing_account_id}:role/cd_*",
    ]
  }
}
