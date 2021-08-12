# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

# AWS
variable "keypair_public" {
  description = "The public SSH key, for SSH access to newly-created instances"
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
}

#
# VPC
#
variable "cidr" {
  type        = string
  description = "The CIDR of the VPC."
  default     = "10.0.0.0/16"
}

variable "private_subnets" {
  type        = list(string)
  description = "The private subnets for the VPC."
  default     = ["10.0.1.0/24"]
}

variable "public_subnets" {
  type        = list(string)
  description = "The public subnets for the VPC."
  default     = ["10.0.0.0/24"]
}

data "aws_availability_zones" "available" {
  state = "available"
}

#
# Bastion
#
variable "bastion_allowed_networks" {
  description = "Networks allowed to connect to the bastion using SSH"
  default     = ["0.0.0.0/0"]
}

variable "bastion_instance_type" {
  description = "Instance type for the bastion"
  default     = "t3.micro"
}


#
# Nexus Repository
#
variable "nexus_instance_type" {
  description = "Instance type for the Nexus Repository"
  default     = "t3.micro"
}

variable "nexus_disk_size" {
  description = "Disk size for the Nexus Repository (Go)"
  default = 20
}

variable "nexus_port" {
  description = "Port where Nexus Repository service is exposed"
  default = 8081
}

# Tags
variable "extra_tags" {
  default = {}
}

locals {
  standard_tags = {
    "cycloid.io" = "true"
    env          = var.env
    project      = var.project
    customer     = var.customer
  }
  merged_tags = merge(local.standard_tags, var.extra_tags)
}