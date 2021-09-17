#
# Node instance outputs
#
output "node_ip" {
  description = "The IP address the node server"
  value       = module.node.node_ip
}

output "node_port" {
  description = "Port where node service is exposed"
  value       = module.node.node_port
}

output "node_os_user" {
  description = "The username to use to connect to the node instance via SSH."
  value       = module.node.node_os_user
}

