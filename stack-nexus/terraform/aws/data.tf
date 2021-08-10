# Get access to the Terraform remote state file which created the VPC and the bastion to be used in this stack
data "terraform_remote_state" "infra" {
  backend = "s3"

  config = {
    bucket = var.terraform_storage_bucket_name
    key    = "infra/${var.env}/infra-${var.env}.tfstate"
    region = var.aws_region
  }
}