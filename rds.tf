#Creating publicly innaccesible RDS instance 
resource "aws_db_instance" "my-db" {
  allocated_storage      = 20
  identifier             = var.rds_name
  storage_type           = var.rds_storage_type
  engine                 = var.rds_engine
  engine_version         = var.rds_version
  instance_class         = var.rds_instance
  db_name                = var.rds_db_name
  username               = var.rds_username
  password               = var.rds_password
  parameter_group_name   = var.rds_param_group
  publicly_accessible    = false
  skip_final_snapshot    = true
  multi_az               = false
  db_subnet_group_name   = aws_db_subnet_group.rds.name
  vpc_security_group_ids = ["${aws_security_group.rds.id}"]
}