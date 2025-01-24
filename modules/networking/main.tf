resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = {
    name=var.igw_name
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags ={
    name=var.public_route_table_name
  }
}

resource "aws_route_table_association" "public-subnet-1-association" {
  subnet_id = var.subnet_1_id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public-subnet-2-association" {
  subnet_id = var.subnet_2_id
  route_table_id = aws_route_table.public-route-table.id
}


