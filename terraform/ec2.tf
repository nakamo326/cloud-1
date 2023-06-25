resource "aws_instance" "ec2" {
  # Ubuntu 22.04 LTS
  ami           = "ami-0d52744d6551d851e"
  instance_type = "t2.micro"
  tags = {
    Name = "cloud-1"
  }
  root_block_device {
    volume_type = "gp2"
    volume_size = 30
  }
}

