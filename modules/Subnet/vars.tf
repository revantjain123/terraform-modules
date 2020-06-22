variable "Subnet_count" {
	type = number
	description  = "No. of subnets"
}

variable "availability_zone" {
	type = list
}

variable "cidr_block" { 
	type = list
}

variable "map_public_ip_on_launch" { 
	type = bool
	default =false
}

variable "assign_ipv6_address_on_creation" {
	type = bool 
	default = false
}

variable "vpc_id" {
	type = string
}
variable "tags" { 
	type =list
	default = []
}
