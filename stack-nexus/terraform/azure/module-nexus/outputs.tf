#
# VPC outputs
#
output "vpc_id" {
  description = "The VPC ID for the VPC"
  value       = azurerm_virtual_network.nexus.id
}

output "vpc_cidr" {
  description = "The CIDR for the VPC"
  value       = var.cidr
}

output "private_subnets" {
  description = "The private subnets for the VPC"
  value       = var.private_subnets
}

output "public_subnets" {
  description = "The public subnets for the VPC"
  value       = var.public_subnets
}

#
# Bastion outputs
#
output "bastion_ip" {
  description = "The EIP attached to the bastion EC2 server"
  value       = azurerm_linux_virtual_machine.bastion.public_ip_address
}

output "bastion_os_user" {
  description = "Admin username to connect to instance via SSH"
  value       = var.bastion_os_user
}

output "bastion_allowed_networks" {
  description = "Networks allowed to connect to the bastion using SSH"
  value       = var.bastion_allowed_networks
}

output "bastion_sg" {
  description = "The bastion security group ID."
  value       = azurerm_network_security_group.bastion.id
}

#
# Nexus Repository outputs
#
output "nexus_ip" {
  description = "The IP address the Nexus Repository EC2 server"
  value       = azurerm_linux_virtual_machine.nexus.public_ip_address
}

output "nexus_os_user" {
  description = "Admin username to connect to instance via SSH"
  value       = var.nexus_os_user
}

output "nexus_port" {
  description = "Port where Nexus Repository service is exposed"
  value = var.nexus_port
}

output "nexus_admin_password" {
  description = "Initial admin password in case of first installation"
  value = var.nexus_admin_password
}

output "nexus_sg" {
  description = "The Nexus Repository security group ID."
  value       = azurerm_network_security_group.nexus.id
}