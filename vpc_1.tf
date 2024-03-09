# Create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true" 

  tags = {
    Name = "my_vpc"
  }
}

# Create public subnet
resource "aws_subnet" "public-1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  map_customer_owned_ip_on_launch = "true"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "public-1"
  }
}

resource "aws_subnet" "public-2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24"
  map_customer_owned_ip_on_launch = "true"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "public-2"
  }
}

resource "aws_subnet" "public-3" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.3.0/24"
  map_customer_owned_ip_on_launch = "true"
  availability_zone = "ap-south-1c"

  tags = {
    Name = "public-3"
  }
}

# Create private subnet
resource "aws_subnet" "private-1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.4.0/24"
  map_customer_owned_ip_on_launch = "false"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "private-1"
  }
}

resource "aws_subnet" "private-2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.5.0/24"
  map_customer_owned_ip_on_launch = "false"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "private-2"
  }
}

resource "aws_subnet" "private-3" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.6.0/24"
  map_customer_owned_ip_on_launch = "false"
  availability_zone = "ap-south-1c"
  tags = {
    Name = "private-3"
  }
}

# Create Internet-Gateway
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my-igw"
  }
}

# Create routing table
resource "aws_route_table" "my_route_table_public" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }
  tags = {
    Name = "my_route_table_public"
  }
}

# Create route table association for public subnet
resource "aws_route_table_association" "public_route-1" {
  subnet_id      = aws_subnet.public-1.id
  route_table_id = aws_route_table.my_route_table_public.id
}

resource "aws_route_table_association" "public_route-2" {
  subnet_id      = aws_subnet.public-2.id
  route_table_id = aws_route_table.my_route_table_public.id
}

resource "aws_route_table_association" "public_route-3" {
  subnet_id      = aws_subnet.public-3.id
  route_table_id = aws_route_table.my_route_table_public.id
}