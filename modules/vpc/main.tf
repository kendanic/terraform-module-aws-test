#create vpc
resource "aws_vpc" "vpc" {
    cidr_block                  = var.vpc_cidr
    instance_tenancy            = "default"
    enable_dns_hostnames        = true
    enable_dns_support          = true

    tags = {
        Name                    = "${var.project_name}-vpc"
    }
}

# create internet gateway and attach it to vpc
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id                        = aws_vpc.vpc.id

  tags = {
    Name                        = "${var.project_name}-igw"
  }
}

# use data source to get list of all availability zones
# Declare the data source
data "aws_availability_zones" "availability_zones" {}

# create public subnet az1
resource "aws_subnet" "public_subnet_az1" {
    vpc_id                     = aws_vpc.vpc.id
    cidr_block                 = var.public_subnet_az1_cidr
    availability_zone          = data.aws_availability_zones.availability_zones.names[0]
    map_public_ip_on_launch    = true
    tags = {
        Name = "public sunet az1"
    }
}

# create public_subnet_az2
resource "aws_subnet" "public_subnet_az2" {
    vpc_id                     = aws_vpc.vpc.id
    cidr_block                 = var.public_subnet_az2_cidr
    availability_zone          = data.aws_availability_zones.availability_zones.names[1]
    map_public_ip_on_launch    = true
    tags = {
        Name = "public sunet az2"
    }
}

# create route table and add public route
resource "aws_route_table" "public_route_table" {
  vpc_id                     = aws_vpc.vpc.id

  route {
    cidr_block               = "0.0.0.0/0"
    gateway_id               = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name                     = "public route table"
  }
}

# associate public subnet az1 with the public route table
resource "aws_route_table_association" "public_subnet_az1_route_table_association" {
  subnet_id                  = aws_subnet.public_subnet_az1.id
  route_table_id             = aws_route_table.public_route_table.id
}

# associate publi subnet az2 with pulic subnet az2
resource "aws_route_table_association" "public_subnet_az2_route_table_association" {
  subnet_id                  = aws_subnet.public_subnet_az2.id
  route_table_id             = aws_route_table.public_route_table.id
}

# creatr private app subnet az1
resource "aws_subnet" "private_app_subnet_az1" {
  vpc_id                     = aws_vpc.vpc.id
  cidr_block                 = var.private_app_subnet_az1_cidr
  availability_zone          = data.aws_availability_zones.availability_zones.names[0]
  map_public_ip_on_launch    = false

  tags = {
    Name                     = "private app subnet az1"
  }
}

# creatr private app subnet az2
resource "aws_subnet" "private_app_subnet_az2" {
  vpc_id                     = aws_vpc.vpc.id
  cidr_block                 = var.private_app_subnet_az2_cidr
  availability_zone          = data.aws_availability_zones.availability_zones.names[1]
  map_public_ip_on_launch    = false

  tags = {
    Name                     = "private app subnet az2"
  }
}

# creatr private data subnet az1
resource "aws_subnet" "private_data_subnet_az1" {
  vpc_id                     = aws_vpc.vpc.id
  cidr_block                 = var.private_data_subnet_az1_cidr
  availability_zone          = data.aws_availability_zones.availability_zones.names[0]
  map_public_ip_on_launch    = false

  tags = {
    Name                     = "private data subnet az1"
  }
}

# creatr private data subnet az2
resource "aws_subnet" "private_data_subnet_az2" {
  vpc_id                     = aws_vpc.vpc.id
  cidr_block                 = var.private_data_subnet_az2_cidr
  availability_zone          = data.aws_availability_zones.availability_zones.names[1]
  map_public_ip_on_launch    = false

  tags = {
    Name                     = "private data subnet az2"
  }
}
