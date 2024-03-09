# Create Elastic Ip
resource "aws_eip" "my_vpc_eip" {
    domain   = "vpc"
    vpc = "true"
}

# Cfreate NAT gatewy
resource "aws_nat_gateway" "my_vpc_nat" {
  allocation_id = aws_eip.my_vpc_eip.id
  subnet_id     = aws_subnet.public-1.id

  tags = {
    Name = "y_vpc_nat"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.my-igw]
}

resource "aws_route_table" "my_route_table_private" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "10.0.1.0/24"
    nat_gateway_id = aws_nat_gateway.my_vpc_nat.id
  }
  tags = {
    Name = "my_route_table_private"
  }
}

# Create route table association for private subnet
resource "aws_route_table_association" "private_route_1" {
  subnet_id      = aws_subnet.private-1.id
  route_table_id = aws_route_table.my_route_table_private.id
}

resource "aws_route_table_association" "private_route_2" {
  subnet_id      = aws_subnet.private-2.id
  route_table_id = aws_route_table.my_route_table_private.id
}

resource "aws_route_table_association" "private_route_3" {
  subnet_id      = aws_subnet.private-3.id
  route_table_id = aws_route_table.my_route_table_private.id
}