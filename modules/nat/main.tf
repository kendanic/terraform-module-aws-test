# allocate elastic ip. this eip will be used for the nat-gateway in the subnet public subnet az1
resource "aws_eip" "eip-nat-gateway-az1" {
  domain = "vpc"

  tags = {
    Name = "elastic IP nat gateway az1"
  }
}

# allocate elastic ip. this eip will be used for the nat-gateway in the public subnet az2
resource "aws_eip" "eip_nat_gateway-az2" {
  domain = "vpc"

  tags = {
    Name = "elastic IP nat gateway az2"
  }
}

# create nat gateway in public subnet az1
resource "aws_nat_gateway" "nat-gateway-az1" {
  allocation_id = aws_eip.eip-nat-gateway-az1.id
  subnet_id     = var.public_subnet_az1_id

  tags = {
    Name = "nat gateway az1"
  }
  # to ensure proper ordering, it is recommended to add an explicit dependency
  #  depends_on = [var.internet_gateway.id]
}

# create nat gateway in public subnet az2
resource "aws_nat_gateway" "nat-gateway-az2" {
  allocation_id = aws_eip.eip_nat_gateway-az2.id
  subnet_id     = var.public_subnet_az2_id

  tags = {
    Name = "nat gateway az2"
  }
  # to ensure proper ordering, it is recommended to add an explicit dependency
  #  depends_on                                     = [var.internet_gateway.id]
}

# create private route table Private-Route Table-1 and add route through Nat gateway az1
resource "aws_route_table" "private-root-table-1" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gateway-az1.id
  }

  tags = {
    Name = "Private root table 1"
  }
}

# associate private app subnet az1 with the private route table 1
resource "aws_route_table_association" "private_app_subnet_az1" {
  subnet_id      = var.private_app_subnet_az1_id
  route_table_id = aws_route_table.private-root-table-1.id
}

# associate private data subnet az1 with route table 1
resource "aws_route_table_association" "private_data_subnet_az1" {
  subnet_id      = var.private_data_subnet_az1_id
  route_table_id = aws_route_table.private-root-table-1.id
}

# create private private-route-table-2 and add route through nat gateway az2
resource "aws_route_table" "private-route-table-az2" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gateway-az2.id
  }

  tags = {
    Name = "private route table z2"
  }
}

# associate private app subnet az2 with private route table az2
resource "aws_route_table_association" "private_app_subnet_az2" {
  subnet_id      = var.private_app_subnet_az2_id
  route_table_id = aws_route_table.private-route-table-az2.id
}

# associate private data subnet az2 with private route table az2
resource "aws_route_table_association" "private_data_subnet_az2" {
  subnet_id      = var.private_data_subnet_az2_id
  route_table_id = aws_route_table.private-route-table-az2.id
}
