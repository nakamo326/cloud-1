resource "aws_instance" "ec2" {
  # Ubuntu 22.04 LTS TODO: check the latest version
  ami                    = "ami-0eba6c58b7918d3a1"
  instance_type          = "t2.micro"
  key_name               = var.key_pair_name
  subnet_id              = aws_subnet.subnet.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  tags = {
    Name = "cloud-1-ec2"
  }
  root_block_device {
    volume_type = "gp2"
    volume_size = 30
  }
}

# security group for ec2, allow ssh, http, https
resource "aws_security_group" "ec2_sg" {
  name   = "cloud-1-ec2-sg"
  vpc_id = aws_vpc.vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "cloud-1-ec2-sg"
  }
}
