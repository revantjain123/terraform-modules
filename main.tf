/*terraform {
  	backend "s3" {}
	}*/
provider "aws" {
	region ="eu-west-1"
}

/*
module "Subnet" {
	source				= "./modules/Subnet"
	Subnet_count 			= var.Subnet_count
	availability_zone		= var.Subnet_availability_zone
	cidr_block 			= var.Subnet_cidr_block
	map_public_ip_on_launch		= var.Subnet_map_public_ip_on_launch
	assign_ipv6_address_on_creation = var.Subnet_assign_ipv6_address_on_creation
	vpc_id 				= var.vpc_id
	tags 				= var.Subnet_tags
	}
*/

module "EFS" {
	source 				= "./modules/EFS"
	tags        			= var.tags
	subnets 			= var.EFS_subnets
	identifier 			= var.EFS_identifier
	encrypted 			= var.EFS_encrypted
	kms_key_id 			= var.EFS_kms_key_id
	performance_mode 		= var.EFS_performance_mode
	provisioned_throughput_in_mibps = var.EFS_provisioned_throughput_in_mibps
	throughput_mode 		= var.EFS_throughput_mode
	transition_to_ia 		= var.EFS_transition_to_ia
	EFS_SG_vpc_id 			= var.vpc_id
	EFS_SG_tags 			= var.EFS_SG_tags
	EC2_security_group 		= module.EC2.ec2_security_group
	worker_security_group 		= module.ASG.worker_security_group  
	}


module "RDS" {
	source 				= "./modules/RDS"
	tags        			= var.tags
	instance_class			= var.RDS_instance_class
	username 			= var.RDS_username
	password 			= var.RDS_password
	storage  			= var.RDS_storage
	storage_type 			= var.RDS_storage_type
	engine_version 			= var.RDS_engine_version
	identifier 			= var.RDS_identifier
	RDS_SG_vpc_id 			= var.vpc_id
	RDS_SG_tags 			= var.RDS_SG_tags
	RDS_parameter_group_name 	= var.RDS_parameter_group_name
	RDS_parameter_family 		= var.RDS_parameter_family
	EC2_security_group 		= module.EC2.ec2_security_group
	worker_security_group 		= module.ASG.worker_security_group
	RDS_subnet_name			= var.RDS_subnet_name
	RDS_subnet_description		= var.RDS_subnet_description
	RDS_subnet_ids 			= var.RDS_subnet_ids
	RDS_subnet_tags			= var.RDS_subnet_tags
	}


module "ElastiCache"  {
	source 				= "./modules/ElastiCache"
	tags        			= var.tags
	port 				= var.ElastiCache_port
	engine_version 			= var.ElastiCache_engine_version
	replicas		 	= var.ElastiCache_replicas
	numnodes 			= var.ElastiCache_numnodes
	subnet_ids 			= var.ElastiCache_subnet_ids
	instance_type 			= var.ElastiCache_instance_type
	availability_zones 		= var.ElastiCache_availability_zones
	replication_group_id 		= var.ElastiCache_replication_group_id
	parameter_group_name 		= var.ElastiCache_parameter_group_name
	ElastiCache_SG_vpc_id 		= var.vpc_id
	ElastiCache_SG_tags 		= var.ElastiCache_SG_tags
	elasticache_parameter_name 	= var.elasticache_parameter_name
	elasticache_parameter_family 	= var.elasticache_parameter_family
	worker_security_group 		= module.ASG.worker_security_group
	EC2_security_group 		= module.EC2.ec2_security_group
	}


module "EC2" {
	source 				= "./modules/EC2"
	tags        			= var.tags
	instance_type 			= var.EC2_instance_type
	imageid 			= var.imageid
	key_name 			= var.EC2_key_name
	availability_zone 		= var.EC2_availability_zone
	subnet_id 			= var.EC2_subnet_id
	dns_name 			= module.EFS.efs_dns_name
	efs_id 				= module.EFS.efs_id
	efs_mount_path	 		= var.efs_mount_path
	EC2_SG_vpc_id 			= var.vpc_id
	EC2_SG_rule 			= var.EC2_SG_rule
	EC2_SG_tags 			= var.EC2_SG_tags
	EC2_root_volume_size		= var.EC2_root_volume_size
	}


module "ASG" {
	source 				= "./modules/ASG"
	imageid 			= var.imageid
	instance_type			= var.ASG_instance_type
	keyname 			= var.ASG_keyname
	max 				= var.ASG_count
	min 				= var.ASG_count
	desired 			= var.ASG_count
	availability_zones 		= var.ASG_availability_zones
	health_check_grace_period 	= var.ASG_health_check_grace_period
	default_cooldown 		= var.ASG_default_cooldown
	dns_name 			= module.EFS.efs_dns_name
	efs_mount_path 			= var.efs_mount_path
	efs_id 				= module.EFS.efs_id
	ASG_SG_vpc_id 			= var.vpc_id
	ASG_SG_tags 			= var.ASG_SG_tags
	ASG_subnet_ids 			= var.ASG_subnet_ids
	EC2_security_group 		= module.EC2.ec2_security_group
	ASG_tags 			= var.ASG_tags
	Launch_template_tags 		= var.Launch_template_tags
	ASG_ebs_size			= var.ASG_ebs_size
	}
