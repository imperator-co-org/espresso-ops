data "aws_ami" "base" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.base_image_filter]
  }
}

resource "aws_eip" "main" {
  count  = var.use_eip ? 1 : 0
  domain = "vpc"
}

resource "aws_eip_association" "eip_assoc" {
  count         = var.use_eip ? 1 : 0
  instance_id   = aws_instance.main.id
  allocation_id = aws_eip.main[count.index].id
}

resource "aws_security_group" "main" {
  vpc_id = var.vpc_id
  name   = "${var.project}-${var.env}-${var.instance_name}-sg"

  dynamic "ingress" {
    for_each = var.inbound_ip_rules
    content {
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "main" {
  ami                    = data.aws_ami.base.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.main.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_connect_profile.name

  root_block_device {
    volume_type = "gp3" # Default use gp3 for best p/p
    volume_size = var.root_disk_size
  }

  dynamic "ebs_block_device" {
    for_each = var.create_data_disk ? [1] : []

    content {
      device_name = "/dev/xvdb" # Data disk device name
      volume_type = "gp3"
      volume_size = var.data_disk_size
    }
  }

  lifecycle {
    ignore_changes = [ami]
  }
  tags = {
    Name = "${var.project}-${var.env}-${var.instance_name}"
  }
}
