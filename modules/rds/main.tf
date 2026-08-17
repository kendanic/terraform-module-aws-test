resource "aws_db_subnet_group" "db-subnet" {
  name       = var.db_subnet_group_name
  subnet_ids = [var.private_data_subnet_az1_id, var.private_data_subnet_az2_id] # Replace with your private subnet IDs
}

resource "aws_db_instance" "db" {
  identifier              = "rds-database-instance"
  engine                  = "mysql"
  engine_version          = "5.7.44"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  username                = var.db_username
  password                = var.db_password
  db_name                 = var.db_name
  multi_az                = false
  storage_type            = "gp2"
  storage_encrypted       = false
  publicly_accessible     = false
  skip_final_snapshot     = true
  backup_retention_period = 0

  vpc_security_group_ids = [var.db_sg_id]

  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name

  tags = {
    Name = "rds-database"
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "rds-db-subnet-group"
  subnet_ids = [var.private_data_subnet_az1_id, var.private_data_subnet_az2_id]

  tags = {
    Name = "rds-db-subnet-group"
  }
}
