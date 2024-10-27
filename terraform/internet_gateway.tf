
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "cloud-1-igw"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "cloud-1-route-table"
  }
}

resource "aws_route" "route" {
  route_table_id         = aws_route_table.route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "subnet_association" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "dummy_subnet_association" {
  subnet_id      = aws_subnet.dummy_subnet.id
  route_table_id = aws_route_table.route_table.id
}
