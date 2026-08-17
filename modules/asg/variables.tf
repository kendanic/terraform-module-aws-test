## variable.tf

variable "project_name"{}
variable "ami" {
    default = "ami-04a81a99f5ec58529"
}
variable "cpu" {
    default = "t2.micro"
}
variable "key_name" {}
variable "client_sg_id" {}
variable "max_size" {
    default = 5
}
variable "min_size" {
    default = 2
}
variable "desired_cap" {
    default = 2
}
variable "asg_health_check_type" {
    default = "ELB"
}
variable "private_app_subnet_az1_id" {}
variable "private_app_subnet_az2_id" {}
variable "tg_arn" {}