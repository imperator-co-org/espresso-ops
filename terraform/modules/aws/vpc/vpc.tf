locals {
  public_subnets = {
    for x in var.public_subnets : x.zone => x
  }
  private_subnets = {
    for x in var.private_subnets : x.zone => x
  }
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.project}-${var.env}"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_subnet" "public" {
  for_each                = local.public_subnets
  cidr_block              = each.value.cidr
  availability_zone       = "${var.region}${each.value.zone}"
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project}-${var.env}-public-subnet-${each.key}"
  }
}

resource "aws_route_table_association" "public" {
  for_each       = local.public_subnets
  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
}

resource "aws_subnet" "private" {
  for_each          = local.private_subnets
  cidr_block        = each.value.cidr
  availability_zone = "${var.region}${each.value.zone}"
  vpc_id            = aws_vpc.main.id
  tags = {
    Name = "${var.project}-${var.env}-private-subnet-${each.key}"
  }
}

resource "aws_route_table_association" "private" {
  for_each       = local.private_subnets
  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private.id
}
