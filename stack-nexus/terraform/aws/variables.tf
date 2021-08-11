# Cycloid variables
variable "env" {}
variable "project" {}
variable "customer" {}

# AWS variables
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {
  description = "AWS region where to create servers."
  default     = "eu-west-1"
}
variable "keypair_public" {}

#
# VPC infra module variables
#
variable "cidr" {}
variable "private_subnets" {}
variable "public_subnets" {}

#
# Bastion infra module variables
#
variable "bastion_allowed_networks" {}
variable "bastion_instance_type" {}

#
# Nexus Repository infra
#
variable "nexus_instance_type" {}
variable "nexus_disk_size" {}