terraform {
  backend "s3" {
    bucket  = "bitelio"
    key     = "production"
    region  = "eu-central-1"
    encrypt = "true"
  }
}
