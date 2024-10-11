resource "aws_db_parameter_group" "main" {
  name   = "${local.prefix}-${var.instance_name}-pg"
  family = var.parameter_group_family

  dynamic "parameter" {
    for_each = var.parameter_group_params
    content {
      name  = parameter.value["name"]
      value = parameter.value["value"]
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "main" {
  vpc_id = var.vpc_id
  name   = "${var.project}-${var.env}-${var.instance_name}-sg"

  dynamic "ingress" {
    for_each = var.inbound_rules
    content {
      from_port       = ingress.value["from_port"]
      to_port         = ingress.value["to_port"]
      protocol        = ingress.value["protocol"]
      cidr_blocks     = ingress.value["cidr_blocks"]
      security_groups = ingress.value["security_groups"]
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

resource "aws_db_subnet_group" "main" {
  name       = "${local.prefix}-${var.instance_name}-subnet"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "main" {
  allocated_storage      = var.instance_storage
  identifier             = "${local.prefix}-${var.instance_name}"
  db_name                = var.default_database_name
  engine                 = var.instance_engine
  engine_version         = var.instance_engine_version
  instance_class         = var.instance_type
  username               = var.default_username
  password               = var.default_password
  parameter_group_name   = aws_db_parameter_group.main.name
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.main.id]
}
