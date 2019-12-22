terraform {
  backend "s3" {
    bucket         = "bitelio"
    key            = "testing"
    region         = "eu-central-1"
    encrypt        = "true"
    dynamodb_table = "terraform"
  }
}
