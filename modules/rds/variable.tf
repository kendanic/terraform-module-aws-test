## variable.tf file

variable "db_subnet_group_name" {
  default = "db_subnet_group"
}
variable "private_data_subnet_az1_id" {}
variable "private_data_subnet_az2_id" {}
variable "db_username" {}
variable "db_password" {}
variable "db_sg_id" {}

variable "db_sub_name" {
    default = "book-shop-db-subnet-a-b"
}
variable "db_name" {
    default = "testdb"
}