output "ec2_dns" {
  value = aws_instance.ec2.public_dns
}
