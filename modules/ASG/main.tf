resource "aws_security_group" "airflow" {
	description 			= "Allow airflow worker inbound traffic"
	vpc_id      			= var.ASG_SG_vpc_id

	ingress {
		from_port 		= 8793
		to_port 		= 8793
 		protocol 		= "tcp"
		security_groups 	= [var.EC2_security_group]
		description 		= "Allow tls from airflow-webserver"
		}
  	egress {
    		from_port   		= 0
    		to_port     		= 0
    		protocol    		= "-1"
    		cidr_blocks 		= ["0.0.0.0/0"]
    		description 		= "Outbound tls from airflow-worker"
  		}
  	tags 				= var.ASG_SG_tags
	}
	
resource "aws_launch_template" "Airflow" {
    	name 				= "Airflow"
    	image_id 			= var.imageid
    	instance_type 			= var.instance_type
    	vpc_security_group_ids 		= [aws_security_group.airflow.id]
    	key_name 			= var.keyname
    	tag_specifications {
       		resource_type 		= "instance"
     		tags 			= var.Launch_template_tags
    		}
	block_device_mappings {
    		device_name 		= "/dev/sda1"
    		ebs {
      			volume_size 	= var.ASG_ebs_size
    			}
  		}
   	tags 				= var.Launch_template_tags
    	user_data 			= data.template_cloudinit_config.config.rendered
}

resource "aws_autoscaling_group" "Airflow" {
   	name                      	= "Airflow"
   	max_size                  	= var.max
   	min_size                  	= var.min
   	availability_zones        	= var.availability_zones
   	health_check_grace_period 	= var.health_check_grace_period
   	health_check_type         	= "EC2"
   	desired_capacity          	= var.desired
   	default_cooldown          	= var.default_cooldown
   	launch_template {
        	id     			= aws_launch_template.Airflow.id
        	version 		= "$Latest"
        	}
   	vpc_zone_identifier 		=  var.ASG_subnet_ids
 	tags 				= var.ASG_tags
}

output "worker_security_group" {
	value 				= aws_security_group.airflow.id
}
