resource "aws_subnet" "airflow" {
  count = var.Subnet_count
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_block[count.index]
  availability_zone = var.availability_zone[count.index]
  map_public_ip_on_launch = var.map_public_ip_on_launch
  assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation 
  tags =  var.tags[count.index]
}
