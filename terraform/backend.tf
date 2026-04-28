terraform {
  backend "s3" {
    endpoint = "fra1.digitaloceanspaces.com"
    bucket   = "kohut-bucket"
    key      = "terraform.tfstate"
    region   = "us-east-1"

    skip_credentials_validation = true
    skip_metadata_api_check     = true
  }
}
