output "efs_dns_name" {
    value = aws_efs_file_system.airflow_EFS.dns_name
}

output "efs_id" {
	value = aws_efs_file_system.airflow_EFS.id
}

