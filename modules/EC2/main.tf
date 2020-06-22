resource "aws_security_group" "airflow" {
	description 			= "Allow airflow master inbound traffic"
	vpc_id      			= var.EC2_SG_vpc_id

	dynamic "ingress" {
    		for_each 		= var.EC2_SG_rule
    		content {
      			from_port 	= ingress.value["from_port"]
      			to_port   	= ingress.value["to_port"]
      			protocol  	= ingress.value["protocol"]
      			cidr_blocks 	= ingress.value["cidr_blocks"]
      			description 	= ingress.value["description"]
    			}
 	 	}
 	 egress {
    		from_port   		= 0
    		to_port     		= 0
    		protocol    		= "-1"
    		cidr_blocks 		= ["0.0.0.0/0"]
    		description 		= "outbound tls"
  		}
  	tags 				= var.EC2_SG_tags
	}

resource "aws_instance" "airflow" {
	ami           			= var.imageid
	instance_type 			= var.instance_type
	availability_zone 		= var.availability_zone
	subnet_id 			= var.subnet_id
	vpc_security_group_ids  	= [aws_security_group.airflow.id]
	associate_public_ip_address 	= true
	key_name 			= var.key_name
	root_block_device {
        	volume_size 		= var.EC2_root_volume_size
    		}
	user_data 			= data.template_cloudinit_config.config.rendered  
	tags 				= var.tags
	volume_tags 			= var.tags
	}

output "ec2_security_group" {
	value  = aws_security_group.airflow.id
	}
