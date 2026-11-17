# Elastic IP for NAT Gateway

resource "aws_eip" "finserv_nat_eip" {
  domain = "vpc"

  tags = {
    Name = "finserv-nat-eip"
  }
}

# NAT Gateway in public subnet

resource "aws_nat_gateway" "finserv_nat" {
  allocation_id = aws_eip.finserv_nat_eip.id
  subnet_id     = aws_subnet.public_az1.id

  tags = {
    Name = "finserv-nat-gateway"
  }

  depends_on = [
    aws_internet_gateway.finserv_igw
  ]
}

# Route private subnet traffic through NAT Gateway

resource "aws_route" "private_nat_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.finserv_nat.id
}