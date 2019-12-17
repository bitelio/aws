provider "aws" {
  version             = "2.42.0"
  region              = "eu-central-1"
  allowed_account_ids = [var.production_account_id]
  assume_role {
    role_arn = "arn:aws:iam::${var.production_account_id}:role/admin"
  }
}
