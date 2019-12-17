provider "aws" {
  version             = "2.42.0"
  region              = "eu-central-1"
  allowed_account_ids = [var.principal_account_id]
}
