output "instance_id" {
  value = aws_instance.este.id
}

output "public_ip" {
  value = aws_instance.este.public_ip
}

output "private_ip" {
  value = aws_instance.este.private_ip
}

output "security_group_id" {
  value = aws_security_group.este.id
}
