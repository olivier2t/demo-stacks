# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

# AWS
variable "keypair_public" {
  description = "The public SSH key, for SSH access to newly-created instances"
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

variable "nexus_os_user" {
  description = "Admin username to connect to instance via SSH. Set to 'admin' because we use debian OS."
  default     = "admin"
}

variable "nexus_disk_size" {
  description = "Disk size for the Nexus Repository (Go)"
  default = "20"
}

variable "nexus_port" {
  description = "Port where Nexus Repository service is exposed"
  default = "8081"
}

variable "nexus_admin_password" {
  description = "Initial admin password in case of first installation."
  default = "changeme"
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