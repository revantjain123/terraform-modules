resource "aws_security_group" "airflow_elasticache" {
  description = "Allow airflow rds inbound traffic"
  vpc_id      = var.ElastiCache_SG_vpc_id

ingress {
        from_port = var.port
        to_port = var.port
        protocol = "tcp"
        security_groups = [var.EC2_security_group]
	description = "Allow TLS from airflow-webserver"
}
ingress {
        from_port = var.port
        to_port = var.port
        protocol = "tcp"
        security_groups = [var.worker_security_group]
	description = "Allow TLS from airflow-worker"
}


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
	description = "outbound TLS"  
}
  tags = var.ElastiCache_SG_tags
}

resource "aws_elasticache_parameter_group" "airflow" {
  name   = var.elasticache_parameter_name
  family = var.elasticache_parameter_family
}

resource "aws_elasticache_subnet_group" "airflow" {
  name       = "airflow-cache-subnet"
  subnet_ids = var.subnet_ids
}

resource "aws_elasticache_cluster" "example" {
  cluster_id           = var.replication_group_id
  engine               = "redis"
  node_type            = var.instance_type
  num_cache_nodes      = var.numnodes
  parameter_group_name = aws_elasticache_parameter_group.airflow.id
  engine_version       = var.engine_version
  port                 = var.port
  subnet_group_name    = aws_elasticache_subnet_group.airflow.name
  security_group_ids   = [aws_security_group.airflow_elasticache.id]
  tags                 = var.tags

}

