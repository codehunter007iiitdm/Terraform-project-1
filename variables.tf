variable "vpc_cidr_block" {}
variable "vpc_name" {}

variable "public_subnet_1_cidr_block" {}
variable "public_subnet_1_availability_zone" {}
variable "public_subnet_1_map_public_ip_on_launch" {}
variable "public_subnet_1_name" {}

variable "public_subnet_2_cidr_block" {}
variable "public_subnet_2_availability_zone" {}
variable "public_subnet_2_map_public_ip_on_launch" {}
variable "public_subnet_2_name" {}

variable "igw_name" {}
variable "public_route_table_name" {}

variable "security_group_name" {}

variable "ami" {}
variable "instance_type" {}
