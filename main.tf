module "vpc" {
  source = "./modules/vpc"
  vpc_cidr_block=var.vpc_cidr_block
  vpc_name=var.vpc_name
}

module "public-subnet-1" {
  source = "./modules/subnet"
  vpc_id = module.vpc.vpc_id
  subnet_cidr_block=var.public_subnet_1_cidr_block
  subnet_availability_zone = var.public_subnet_1_availability_zone
  map_public_ip_on_launch = var.public_subnet_1_map_public_ip_on_launch
  public_subnet_name = var.public_subnet_1_name
}

module "public-subnet-2" {
  source = "./modules/subnet"
  vpc_id = module.vpc.vpc_id
  subnet_cidr_block=var.public_subnet_2_cidr_block
  subnet_availability_zone = var.public_subnet_2_availability_zone
  map_public_ip_on_launch = var.public_subnet_2_map_public_ip_on_launch
  public_subnet_name = var.public_subnet_2_name
}

module "networking"{
  source = "./modules/networking"
  vpc_id = module.vpc.vpc_id
  igw_name = var.igw_name
  public_route_table_name = var.public_route_table_name
  subnet_1_id = module.public-subnet-1.subnet_id
  subnet_2_id = module.public-subnet-2.subnet_id
}

module "security-group" {
  source = "./modules/security-group"
  vpc_id=module.vpc.vpc_id
  security_group_name = var.security_group_name
}

module "server-1" {
  source = "./modules/ec2"
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = module.public-subnet-1.subnet_id
  user_data = base64encode(file("userdata1.sh"))
  security_group_id=module.security-group.sg_id
}

module "server-2" {
  source = "./modules/ec2"
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = module.public-subnet-2.subnet_id
  user_data = base64encode(file("userdata2.sh"))
  security_group_id=module.security-group.sg_id
}



