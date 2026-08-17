variable "region" {}
variable "project_name" {}
variable "vpc_cidr" {}
variable "public_subnet_az1_cidr" {}
variable "public_subnet_az2_cidr" {}
variable "private_app_subnet_az1_cidr" {}
variable "private_app_subnet_az2_cidr" {}
variable "private_data_subnet_az1_cidr" {}
variable "private_data_subnet_az2_cidr" {}
variable "db_password" {}
variable "db_username" {}
variable "certificate_domain_name" {
  default = "rioken5171@gmail.com"
}
variable "additional_domain_name" {
  default = "rioken5171@gmail.com"
}
