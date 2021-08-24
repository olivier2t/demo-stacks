# Cycloid variables
variable "env" {}
variable "project" {}
variable "customer" {}

# Azure variables
variable "azure_client_id" {}
variable "azure_client_secret" {}
variable "azure_subscription_id" {}
variable "azure_tenant_id" {}
variable "azure_env" {}
variable "azure_location" {}
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
variable "nexus_port" {}