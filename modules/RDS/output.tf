output "rds_endpoint" {
	value = aws_db_instance.airflow.endpoint
}
output "rds_port" {
	value = aws_db_instance.airflow.port
}
output "rds_username" {
	value= aws_db_instance.airflow.username
}
