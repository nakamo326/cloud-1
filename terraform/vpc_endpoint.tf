resource "aws_vpc_endpoint" "vpc_endpoint" {
  vpc_id              = aws_vpc.vpc.id
  service_name        = "com.amazonaws.ap-northeast-1.ssm"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.vpc_endpoint_sg.id]
  subnet_ids          = [aws_subnet.subnet.id]
  tags = {
    Name = "cloud-1-ssm-endpoint"
  }
}

resource "aws_vpc_endpoint" "ssm_messages_endpoint" {
  vpc_id              = aws_vpc.vpc.id
  service_name        = "com.amazonaws.ap-northeast-1.ssmmessages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.vpc_endpoint_sg.id]
  subnet_ids          = [aws_subnet.subnet.id]
  tags = {
    Name = "cloud-1-ssm-messages-endpoint"
  }
}

resource "aws_vpc_endpoint" "ec2_messages_endpoint" {
  vpc_id              = aws_vpc.vpc.id
  service_name        = "com.amazonaws.ap-northeast-1.ec2messages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.vpc_endpoint_sg.id]
  subnet_ids          = [aws_subnet.subnet.id]
  tags = {
    Name = "cloud-1-ec2-messages-endpoint"
  }
}

# vpc endoint security group
resource "aws_security_group" "vpc_endpoint_sg" {
  name        = "cloud-1-vpc-endpoint-sg"
  description = "Allow traffic from vpc endpoint"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
  tags = {
    Name = "cloud-1-vpc-endpoint-sg"
  }
}
