#
# Infra outputs
#
output "vpc_id" {
  description = "Amazon VPC ID where the Nexus Repository is created."
  value       = data.terraform_remote_state.infra.outputs.vpc_id
}

output "public_subnets" {
  description = "The public subnets for the VPC"
  value       = data.terraform_remote_state.infra.outputs.public_subnets
}

output "bastion_ip" {
  description = "The IP address of the bastion."
  value       = data.terraform_remote_state.infra.outputs.infra.bastion_ip
}

#
# Nexus Repository outputs
#
output "nexus_ip" {
  description = "The IP address the Nexus Repository EC2 server"
  value       = module.nexus.nexus_ip
}

output "nexus_sg" {
  description = "The Nexus Repository security group ID."
  value       = module.nexus.nexus_sg
}