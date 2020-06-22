resource "aws_security_group" "airflow_rds" {
  description = "Allow airflow rds inbound traffic"
  vpc_id      = var.RDS_SG_vpc_id

 ingress {
	from_port = 5432
	to_port = 5432
	protocol = "tcp"
	security_groups = [var.EC2_security_group]
	description  = "Allow TlS from airflow-webserver"
}
ingress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        security_groups = [var.worker_security_group]
	description = "Allow TLS from airflow-worker"
}

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
	description  = "Outbound TLS"
  }
  tags = var.RDS_SG_tags
}

resource "aws_db_parameter_group" "airflow" {
  name   = var.RDS_parameter_group_name
  family = var.RDS_parameter_family
  tags = var.tags
}

resource "aws_db_subnet_group" "airflow" {
  name       = var.RDS_subnet_name
  subnet_ids = var.RDS_subnet_ids
  description = var.RDS_subnet_description	
  tags= var.RDS_subnet_tags
}

resource "aws_db_instance" "airflow" {
  identifier           = var.identifier
  allocated_storage    = var.storage
  storage_type         = var.storage_type
  engine               = "postgres"
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  name                 = var.name
  username             = var.username
  password             = var.password
  port                 = 5432
  skip_final_snapshot  = true
  tags                 = var.tags
  vpc_security_group_ids = [aws_security_group.airflow_rds.id]
  parameter_group_name = aws_db_parameter_group.airflow.id
  db_subnet_group_name = aws_db_subnet_group.airflow.id
}



