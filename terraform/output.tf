output "ec2_instance_id" {
  value = [for instance in aws_instance.ec2 : instance.id]
}
