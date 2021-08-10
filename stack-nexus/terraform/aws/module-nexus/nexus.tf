resource "aws_security_group" "nexus" {
  name        = "nexus"
  description = "Allow accessing the Nexus Repository service from the internet."
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8081
    to_port     = 8081
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
    Name       = "nexus"
  })
}

resource "aws_eip" "nexus" {
  instance = aws_instance.nexus.id
  vpc      = true

  tags = merge(local.merged_tags, {
    Name       = "${var.customer}-nexus"
  })
}

resource "aws_key_pair" "nexus" {
  key_name   = "nexus-key"
  public_key = var.keypair_public
}

resource "aws_instance" "nexus" {
  ami           = data.aws_ami.debian.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.nexus.key_name

  vpc_security_group_ids = [aws_security_group.nexus.id]

  subnet_id               = var.public_subnets[0]
  disable_api_termination = false

  root_block_device {
    volume_size           = var.disk_size
    delete_on_termination = true
  }

  tags = merge(local.merged_tags, {
    Name       = "${var.customer}-nexus"
    role       = "nexus"
  })

  lifecycle {
    ignore_changes = [ami]
  }
}