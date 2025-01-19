resource "aws_vpc" "terraform-project-1" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "terraform-project-1-vpc"
  }
}

resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.terraform-project-1.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "project-1-public-subnet-1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.terraform-project-1.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "project-1-public-subnet-2"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.terraform-project-1.id

  tags = {
    Name = "project-1-internet-gateway"
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.terraform-project-1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "project-1-public-route-table"
  }
}

resource "aws_route_table_association" "public-subnet-1-association" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public-subnet-2-association" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_security_group" "project-1-sg" {
  name="project-1-security-group"
  vpc_id = aws_vpc.terraform-project-1.id

  ingress {
    description="HTTP from VPC"
    from_port=80
    to_port=80
    protocol="tcp"
    cidr_blocks=["0.0.0.0/0"]
  }
  
  ingress {
    description="SSH"
    from_port=22
    to_port=22
    protocol="tcp"
    cidr_blocks=["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name="projrct-1-security-group"
  }

}

resource "aws_instance" "server-1" {
  ami = "ami-04b4f1a9cf54c11d0"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.project-1-sg.id]
  subnet_id = aws_subnet.public-subnet-1.id
  user_data = base64encode(file("userdata1.sh"))
}

resource "aws_instance" "server-2" {
  ami = "ami-04b4f1a9cf54c11d0"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.project-1-sg.id]
  subnet_id = aws_subnet.public-subnet-2.id
  user_data = base64encode(file("userdata2.sh"))
}


