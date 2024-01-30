resource "aws_db_instance" "my_rds_db" {
  allocated_storage    = 20  // Minimum storage for most RDS instances
  storage_type         = "gp2"
  engine               = "mysql"  // You can choose MySQL, PostgreSQL, etc.
  engine_version       = "5.7"  // Ensure this is a version eligible for the free tier
  instance_class       = var.db_instancecl
  username             = var.database_username
  password             = var.db_password
  parameter_group_name = var.parameter_gn
  skip_final_snapshot  = true  // Set to true for dev/test environments to avoid snapshot charges
  publicly_accessible  = false  // Set based on whether you need public access or not

  // Security Group and VPC settings (ensure Lambda can access the RDS instance)
  vpc_security_group_ids = var.rds_security_group_id
  db_subnet_group_name   = var.db_subnet_group_name



}
resource "aws_security_group" "my_rds_sg" {
  name        = "my-rds-sg"
  description = "Security group for RDS DB instance"
  vpc_id      = var.vpc_cidr

  ingress {
    from_port   = 3306  // MySQL port, change it if you're using a different DB
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.cidr_blocks]  // Adjust as necessary, maybe allowing specific IP ranges
  }

  // Add egress rules if needed
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_block_egress]
  }

  tags = {
    Name = "rds-sg"
  }
}

resource "aws_db_subnet_group" "my_rds_subnet_group" {
  name       = "my-db-subnet-group"
  subnet_ids = [var.public_subnet_name.id, var.psubnet.id]

  tags = {
    Name = "My DB Subnet Group"
  }
}
// Assume aws_vpc.my_vpc is defined elsewhere in your Terraform configuration