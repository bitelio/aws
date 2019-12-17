terraform {
  backend "s3" {
    bucket  = "bitelio"
    key     = "principal"
    region  = "eu-central-1"
    encrypt = "true"
  }
}
