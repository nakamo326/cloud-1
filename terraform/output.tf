output "ec2_ip" {
  value = aws_eip.eip.public_ip
}

output "ec2_dns" {
  value = aws_instance.ec2.public_dns
}