resource "aws_key_pair" "node" {
  key_name   = "${var.customer}-${var.project}-${var.env}-node-keypair"
  public_key = var.keypair_public
}