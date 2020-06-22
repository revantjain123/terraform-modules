variable "availability_zones" {
	type = list(string)
	default = [""]
}

variable "replication_group_id" {
	type = string
	default = ""
}

variable "instance_type" {
	type = string
	default = ""
}

variable "port" {
	type =number
	default = 6379
}

variable "engine_version" {
	type = string
	default = ""
}

variable "subnet_ids" {
	type = list(string)
	default = [""]
}

variable "replicas" {
	type = number
	default = 1
}

variable "numnodes" {
	type = number
	default = 2
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

variable "parameter_group_name" {
	type = string
	default = "default.redis5.0.cluster.on"
}

variable "ElastiCache_SG_tags" {
        type = map
        default = {}
}
variable "ElastiCache_SG_vpc_id" {
        type = string
        default =""
}


variable "elasticache_parameter_name" {
	type = string
	default = ""
}

variable "elasticache_parameter_family" {
	type = string
	default = "" 
}



variable "EC2_security_group" {
        type = string
        default = ""
}
variable "worker_security_group" {
        type =string
        default =""
}
