provider "aws" {
  region              = "us-east-1"
  version             = "2.42.0"
  alias               = "us-east-1"
  allowed_account_ids = [var.account]
  assume_role {
    role_arn = "arn:aws:iam::${var.account}:role/admin"
  }
}

