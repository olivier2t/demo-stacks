# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}


#
# VPC
#
variable "vpc_id" {
  type        = string
  description = "The ID of the VPC."
  default     = ""
}

variable "public_subnets" {
  type        = list(string)
  description = "The public subnets for the VPC."
  default     = ["10.0.0.0/24"]
}


#
# Bastion
#
variable "instance_type" {
  description = "Instance type for the Nexus Repository"
  default     = "t3.micro"
}

variable "disk_size" {
  description = "Disk size for the Nexus Repository (Go)"
  default = 20
}

variable "keypair_public" {
  description = "The public SSH key, for SSH access to newly-created instances"
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
}

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