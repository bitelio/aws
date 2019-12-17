variable "testing_account_id" {}

resource "aws_iam_account_alias" "alias" {
  account_alias = "bitelio-testing"
}

module "web" {
  source = "../modules/web"
  domain = "bitelio.dev"
  account = var.testing_account_id
}
