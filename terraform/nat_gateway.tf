resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.subnet.id
  tags = {
    Name = "cloud-1-nat-gateway"
  }
}

resource "aws_eip" "eip" {
  vpc = true
  tags = {
    Name = "cloud-1-nat-eip"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "cloud-1-private-route-table"
  }
}

resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_route_table.id
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

