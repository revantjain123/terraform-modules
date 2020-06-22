variable "imageid" {
    type = string
    default = "ami-09d95fab7fff3776c"
}
variable "instance_type" {
    type = string
    default = "t2.micro"   
}
variable "keyname" {
    type = string
    default = "abc"
}
variable "Launch_template_tags" {
  type    = map
	default ={}
}

variable "max" {
    type = number
    default = 1
}

variable "min" {
    type = number
    default = 1
}

variable "desired" {
    type = number
    default =1
}

variable "availability_zones" {
    type    = list(string)
    default = [""]
}

variable "health_check_grace_period" {
    type = number
    default = 300
}

variable "default_cooldown" {
    type = number
    default = 5
}

variable "vpc_security_group_ids" {
    default = [""]
}

variable "dns_name" {
  type = string
  default = ""
}
variable "efs_mount_path" {
  type = string
  default = ""
}
variable "efs_id" {
        type = string
        default= ""
}

variable "ASG_SG_tags" {
	type = map
	default = {}
}
variable "ASG_SG_vpc_id" {
	type = string
	default =""
}

variable "ASG_subnet_ids" {
	type =list
	default =[]
}
variable "EC2_security_group" {
	type = string
	default =""
}
variable "ASG_tags" {
	type = any
}
variable "ASG_ebs_size" {
	type = number
}
