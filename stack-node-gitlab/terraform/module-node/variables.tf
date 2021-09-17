# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
  default     = ""
}

variable "node_instance_type" {
  description = "Type of the node instance"
  default     = "t3.micro"
}

variable "node_os_user" {
  description = "Admin username to connect to instance via SSH. Set to 'admin' because we use debian OS."
  default     = "admin"
}

variable "node_disk_size" {
  description = "Disk size for the node instance (Go)"
  default = "10"
}

variable "node_port" {
  description = "Port where node app is exposed"
  default = "8081"
}

variable "keypair_public" {
  description = "The public SSH key, for SSH access to newly-created instances"
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