#
# Node instance outputs
#
output "node_ip" {
  description = "The IP address the node server"
  value       = module.nodeapp.node_ip
}

output "node_port" {
  description = "Port where node service is exposed"
  value       = module.nodeapp.node_port
}

output "node_os_user" {
  description = "The username to use to connect to the node instance via SSH."
  value       = module.nodeapp.node_os_user
}

