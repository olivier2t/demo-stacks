module "nexus" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-nexus"
  project  = var.project
  env      = var.env
  customer = var.customer
  #####################################

  #. extra_tags (optional): {}
  #+ Dict of extra tags to add on aws resources. format { "foo" = "bar" }.
  extra_tags = { "demo" = true }

  # . keypair_public: ""
  # + The public SSH key, for SSH access to newly-created instances
  keypair_public = var.keypair_public

  #
  # VPC
  #

  #. cidr: 10.0.0.0/16
  #+ The CIDR of the VPC
  cidr = var.cidr

  #. private_subnets (optional, list): ["10.0.1.0/24"]
  #+ The private subnets for the VPC
  private_subnets = var.private_subnets

  #. public_subnets (optional, list): ["10.0.0.0/24"]
  #+ The public subnets for the VPC
  public_subnets = var.public_subnets

  #
  # Bastion
  #

  #. bastion_allowed_networks: 0.0.0.0/0
  #+ Networks allowed to connect to the bastion using SSH
  bastion_allowed_networks = var.bastion_allowed_networks

  #. bastion_instance_type: t3.micro
  #+ Instance type for the bastion
  bastion_instance_type = var.bastion_instance_type

  #
  # Nexus Repository
  #

  #. nexus_instance_type: 't3.micro'
  #+ Instance type for the Nexus Repository
  nexus_instance_type = var.nexus_instance_type

  #. nexus_disk_size: 20
  #+ Disk size for the Nexus Repository (Go)
  nexus_disk_size = var.nexus_disk_size

  #. nexus_port: 8081
  #+ Port where Nexus Repository service is exposed
  nexus_port = var.nexus_port
}