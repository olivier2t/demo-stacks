#
# VPC outputs
#
output "vpc_id" {
  description = "The VPC ID for the VPC"
  value       = module.infra_vpc.vpc_id
}

output "vpc_cidr" {
  description = "The CIDR for the VPC"
  value       = var.cidr
}

output "private_subnets" {
  description = "The private subnets for the VPC"
  value       = module.infra_vpc.vpc_id
}

output "public_subnets" {
  description = "The public subnets for the VPC"
  value       = module.infra_vpc.vpc_id
}

#
# Bastion outputs
#
output "bastion_ip" {
  description = "The EIP attached to the bastion EC2 server"
  value       = aws_eip.bastion.public_ip
}

output "bastion_sg" {
  description = "The bastion security group ID."
  value       = aws_security_group.bastion.id
}

output "bastion_sg_allow" {
  description = "The security group ID to allow SSH traffic from the bastion to the infra instances"
  value       = aws_security_group.allow_bastion_infra.id
}

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