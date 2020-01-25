variable "principal_account_id" {}
variable "production_account_id" {}
variable "testing_account_id" {}

resource "aws_kms_key" "master" {
  enable_key_rotation = true
}

module "common" {
  source = "../modules/common"
}
