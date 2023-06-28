resource "aws_eip" "eip" {
  instance = aws_instance.ec2.id
  tags = {
    Name = "cloud-1-eip"
  }
}