resource "aws_security_group" "airflow" {
  description = "airflow-EFS"
  vpc_id      = var.EFS_SG_vpc_id

ingress {
        from_port = 2049
        to_port = 2049
        protocol = "tcp"
        security_groups = [var.EC2_security_group]
	description = "Allow TLS from airflow-webserver"
}
ingress {
        from_port = 2049
        to_port = 2049
        protocol = "tcp"
        security_groups = [var.worker_security_group]
	description = "Allow TLS from airflow-worker"
}


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
	description = "Outbound TLS"
  }
  tags = var.EFS_SG_tags
}

resource "aws_efs_mount_target" "airflow_EFS_mount_target" {
    count          = length(var.subnets) > 0 ? length(var.subnets) : 0
    file_system_id = aws_efs_file_system.airflow_EFS.id
    subnet_id      = var.subnets[count.index]
    security_groups = [aws_security_group.airflow.id]
}

                                                    
resource "aws_efs_file_system" "airflow_EFS" {
    creation_token = var.identifier
    tags = var.tags
    throughput_mode = var.throughput_mode
    performance_mode = var.performance_mode
    provisioned_throughput_in_mibps = var.provisioned_throughput_in_mibps
    encrypted = var.encrypted
    kms_key_id = var.kms_key_id
    dynamic "lifecycle_policy" {
        for_each = var.transition_to_ia == "" ? [] : [1]
        content {
            transition_to_ia = var.transition_to_ia
        }
    }
}

