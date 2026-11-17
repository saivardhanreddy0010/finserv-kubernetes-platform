# Get available Availability Zones
data "aws_availability_zones" "available" {
  state = "available"
}

# Create VPC
resource "aws_vpc" "finserv_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "finserv-vpc"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "finserv_igw" {
  vpc_id = aws_vpc.finserv_vpc.id

  tags = {
    Name = "finserv-igw"
  }
}

# Public Subnet - AZ1
resource "aws_subnet" "public_az1" {
  vpc_id                  = aws_vpc.finserv_vpc.id
  cidr_block              = "10.40.1.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "finserv-public-subnet-az1"
    Tier = "Public"
  }
}

# Public Subnet - AZ2
resource "aws_subnet" "public_az2" {
  vpc_id                  = aws_vpc.finserv_vpc.id
  cidr_block              = "10.40.2.0/24"
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "finserv-public-subnet-az2"
    Tier = "Public"
  }
}

# Private Subnet - AZ1
resource "aws_subnet" "private_az1" {
  vpc_id            = aws_vpc.finserv_vpc.id
  cidr_block        = "10.40.11.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "finserv-private-subnet-az1"
    Tier = "Private"
  }
}

# Private Subnet - AZ2
resource "aws_subnet" "private_az2" {
  vpc_id            = aws_vpc.finserv_vpc.id
  cidr_block        = "10.40.12.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "finserv-private-subnet-az2"
    Tier = "Private"
  }
}

# Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.finserv_vpc.id

  tags = {
    Name = "finserv-public-route-table"
  }
}

# Internet Route
resource "aws_route" "public_internet_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.finserv_igw.id
}

# Associate Public Subnet AZ1
resource "aws_route_table_association" "public_az1" {
  subnet_id      = aws_subnet.public_az1.id
  route_table_id = aws_route_table.public_rt.id
}

# Associate Public Subnet AZ2
resource "aws_route_table_association" "public_az2" {
  subnet_id      = aws_subnet.public_az2.id
  route_table_id = aws_route_table.public_rt.id
}

# Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.finserv_vpc.id

  tags = {
    Name = "finserv-private-route-table"
  }
}

# Associate Private Subnet AZ1
resource "aws_route_table_association" "private_az1" {
  subnet_id      = aws_subnet.private_az1.id
  route_table_id = aws_route_table.private_rt.id
}

# Associate Private Subnet AZ2
resource "aws_route_table_association" "private_az2" {
  subnet_id      = aws_subnet.private_az2.id
  route_table_id = aws_route_table.private_rt.id
}