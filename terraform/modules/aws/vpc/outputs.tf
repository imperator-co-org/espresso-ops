output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets" {
  value = {
    for zone, _ in local.public_subnets : zone => aws_subnet.public[zone].id
  }
}

output "private_subnets" {
  value = {
    for zone, _ in local.private_subnets : zone => aws_subnet.private[zone].id
  }
}
