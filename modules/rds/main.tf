resource "aws_db_subnet_group" "db_subnet" {
  name       = "timesheet-db-subnet-group-12345"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "timesheet-db-subnet-group-12345"
  }
}

resource "aws_db_instance" "db" {
  allocated_storage    = 20
  engine              = "mysql"
  instance_class      = "db.t3.micro"
  db_name             = "timesheetdb"
  username            = "admin"
  password            = "Admin1234"
  skip_final_snapshot = true

  db_subnet_group_name   = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids = [var.security_group_id]
}
