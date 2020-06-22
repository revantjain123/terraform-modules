variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "imageid" {
    type = string
    default = "ami-09d95fab7fff3776c"
}

variable "key_name" {
    type = string
    default = "abc"
}
variable "vpc_security_group_ids" {
  default = [""]
}

variable "tags" {
  type    = map
  default = {
    "Name" = "airflow"
    "Owner" = "revant.jain@tothenew.com"
    "Purpose" = "Airflow_learning"
    "BU" = "shivam.khandelwal@tothenew.com"
    "Project" = "Airflow_learning"
  }
}
variable "availability_zone" {
    type = string
    default = ""
}

variable "subnet_id" {
    type = string
    default = ""
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

variable "EC2_SG_rule" {
        type = any
}

variable "EC2_SG_tags" {
        type = map
        default = {}
}
variable "EC2_SG_vpc_id" {
        type = string
        default =""
}
variable "EC2_root_volume_size" {
	type = number
	
}
