provider "aws" {
  profile = "sre"
  region  = "eu-central-1"
  version = "~> 2.0"
}

provider "aws" {
  profile = "sre"
  region  = "us-east-1"
  version = "~> 2.0"
  alias   = "us-east-1"
}
