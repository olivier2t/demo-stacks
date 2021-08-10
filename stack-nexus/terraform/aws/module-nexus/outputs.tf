#
# Nexus Repository outputs
#
output "nexus_ip" {
  description = "The IP address the Nexus Repository EC2 server"
  value       = aws_eip.nexus.public_ip
}

output "nexus_sg" {
  description = "The Nexus Repository security group ID."
  value       = aws_security_group.nexus.id
}