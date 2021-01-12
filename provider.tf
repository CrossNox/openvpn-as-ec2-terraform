provider "aws" {
  version    = "~> 2.7"
  profile = var.profile
  shared_credentials_file = "~/.aws/credentials"
  region  = var.region
}
