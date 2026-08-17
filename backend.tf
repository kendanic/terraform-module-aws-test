# store the terraform state file in s3 bucket.
terraform {
  backend "s3" {
    bucket         = "buckterra5171"
    key            = "project/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    use_lockfile   = true
  }
}