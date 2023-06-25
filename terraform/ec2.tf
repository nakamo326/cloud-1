resource "aws_instance" "ec2" {
  # Ubuntu 22.04 LTS
  ami           = "ami-0d52744d6551d851e"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subnet.id
  tags = {
    Name = "cloud-1-ec2"
  }
  root_block_device {
    volume_type = "gp2"
    volume_size = 30
  }
}

