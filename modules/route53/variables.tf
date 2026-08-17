## variable.tf file

variable "hosted_zone_name" {
    default = "rioken5171@gmail.com"
}
variable "cloudfront_domain_name" {}
variable "cloudfront_hosted_zone" {
    description = "two above commands are just for refactoring and validating. Actual work begins now"
}