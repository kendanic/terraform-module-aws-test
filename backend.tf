# store the terraform state file in s3 bucket.
terraform {
  backend "s3" {
    bucket = "statebucket123"
    key    = "project/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "remote-backend"
  }
}