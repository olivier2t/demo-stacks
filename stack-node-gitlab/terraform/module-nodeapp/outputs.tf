#
# outputs
#
output "node_ip" {
  description = "The IP address the node instance"
  value       = aws_instance.node.public_ip
}

output "node_os_user" {
  description = "Admin username to connect to instance via SSH"
  value       = var.node_os_user
}

output "node_port" {
  description = "Port where node Repository service is exposed"
  value = var.node_port
}