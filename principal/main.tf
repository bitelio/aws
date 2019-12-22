variable "principal_account_id" {}
variable "production_account_id" {}
variable "testing_account_id" {}

module "common" {
  source = "../modules/common"
}
