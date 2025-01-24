vpc_cidr_block="10.0.0.0/16"
vpc_name = "terraform-project-1"

public_subnet_1_cidr_block = "10.0.0.0/24"
public_subnet_1_availability_zone = "us-east-1a"
public_subnet_1_name = "public-subnet-1"
public_subnet_1_map_public_ip_on_launch=true

public_subnet_2_cidr_block = "10.0.1.0/24"
public_subnet_2_availability_zone = "us-east-1b"
public_subnet_2_name = "public-subnet-2"
public_subnet_2_map_public_ip_on_launch=true

igw_name = "project-1-igw"
public_route_table_name = "public_route_table"

security_group_name="project-1-security-group"

ami = "ami-04b4f1a9cf54c11d0"
instance_type = "t2.micro"

