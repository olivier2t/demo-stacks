resource "aws_security_group" "bastion" {
  name = "${var.customer}-${var.env}-bastion"
  description = "Allow SSH traffic from the internet to bastion"
  vpc_id = module.infra_vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.bastion_allowed_networks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.env}-bastion"
  })
}


resource "aws_security_group" "allow_bastion_infra" {
  name = "${var.customer}-${var.env}-allow-bastion-infra"
  description = "Allow SSH traffic from the bastion to the infra"
  vpc_id = module.infra_vpc.vpc_id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
    self            = false
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.env}-allow-bastion-infra"
  })
}

resource "aws_eip" "bastion" {
  instance = aws_instance.bastion.id
  vpc = true

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.env}-bastion"
  })
}

resource "aws_instance" "bastion" {
  ami = data.aws_ami.debian.id
  instance_type = var.bastion_instance_type
  key_name = aws_key_pair.nexus.key_name

  vpc_security_group_ids = [aws_security_group.bastion.id]

  subnet_id = var.public_subnets[0]
  disable_api_termination = false

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.env}-bastion"
    role = "bastion"
  })

  lifecycle {
    ignore_changes = [ami]
  }
}