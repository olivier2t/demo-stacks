resource "aws_security_group" "node" {
  name        = "${var.customer}-${var.project}-${var.env}-node"
  description = "Allow accessing the node app from the internet."
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.node_port
    to_port     = var.node_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.merged_tags, {
    Name       = "${var.customer}-${var.project}-${var.env}-node"
  })
}

resource "aws_instance" "node" {
  ami           = data.aws_ami.debian.id
  instance_type = var.node_instance_type
  key_name      = aws_key_pair.node.key_name

  vpc_security_group_ids = [aws_security_group.node.id]

  disable_api_termination = false
  associate_public_ip_address = true

  root_block_device {
    volume_size           = var.node_disk_size
    delete_on_termination = true
  }

  tags = merge(local.merged_tags, {
    Name       = "${var.customer}-${var.project}-${var.env}-node"
    role       = "node"
  })
}