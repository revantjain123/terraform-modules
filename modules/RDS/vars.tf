variable "storage" {
    type = number
    default = 20
}

variable "storage_type" {
    type = string
    default = "gp2"
}

variable "engine_version" {
    type = string
    default = "9.6.1"
}

variable "instance_class"  {
    type = string
    default = "db.t2.micro"
}

variable "name" {
    type = string
    default = "airflowdb"
}

variable "username" {
    type = string
    default = "airflow"
}


variable "password" {
    type = string
    default = "airflow12345"
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

variable "identifier" {
    type = string
    default = "airflow"
}



variable "RDS_SG_tags" {
        type = map
        default = {}
}
variable "RDS_SG_vpc_id" {
        type = string
        default =""
}
variable "RDS_parameter_group_name" {
	type = string
	default =""
}
variable "RDS_parameter_family" {
	type = string
	default =""
}

variable "EC2_security_group" {
	type = string
	default = ""
}
variable "worker_security_group" {
	type =string
	default =""
}

variable "RDS_subnet_name" {
	type = string
}

variable "RDS_subnet_description" {
	type = string
}

variable "RDS_subnet_ids" {
	type = list
}

variable "RDS_subnet_tags" {
	type = map
}
