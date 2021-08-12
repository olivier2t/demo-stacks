#
# VPC outputs
#
output "vpc_id" {
  description = "The VPC ID for the VPC"
  value       = module.nexus.vpc_id
}

output "vpc_cidr" {
  description = "The CIDR for the VPC"
  value       = module.nexus.vpc_cidr
}

output "private_subnet" {
  description = "The private subnet for the VPC"
  value       = module.nexus.private_subnets[0]
}

output "public_subnet" {
  description = "The public subnet for the VPC"
  value       = module.nexus.public_subnets[0]
}

#
# Bastion outputs
#
output "bastion_ip" {
  description = "The EIP attached to the bastion EC2 server"
  value       = module.nexus.bastion_ip
}

output "bastion_user" {
  description = "The username to use to connect to the bastion EC2 server. Set to 'admin' because we use debian OS."
  value       = "admin"
}

output "bastion_sg" {
  description = "The bastion security group ID."
  value       = module.nexus.bastion_sg
}

output "bastion_sg_allow" {
  description = "The security group ID to allow SSH traffic from the bastion to the infra instances"
  value       = module.nexus.bastion_sg_allow
}

#
# Nexus Repository outputs
#
output "nexus_ip" {
  description = "The IP address the Nexus Repository EC2 server"
  value       = module.nexus.nexus_ip
}

output "nexus_port" {
  description = "Port where Nexus Repository service is exposed"
  value       = module.nexus.nexus_port
}

output "nexus_user" {
  description = "The username to use to connect to the Nexus Repository EC2 server. Set to 'admin' because we use debian OS."
  value       = "admin"
}

output "nexus_sg" {
  description = "The Nexus Repository security group ID."
  value       = module.nexus.nexus_sg
}