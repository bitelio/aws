variable "production_account_id" {}
variable "principal_account_id" {}

resource "aws_iam_account_alias" "alias" {
  account_alias = "bitelio-production"
}

module "common" {
  source = "../modules/common"
}

module "web" {
  source    = "../modules/web"
  domain    = "bitelio.com"
  account   = var.production_account_id
  principal = var.principal_account_id
}
