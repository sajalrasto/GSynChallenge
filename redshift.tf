resource "aws_redshift_cluster" "redcluster" {
  cluster_identifier      = "my-redshift-cluster"
  database_name           = "mydatabase"
  master_username         = "sajal"
  master_password         = "Sajal2gsyn"
  node_type               = "dc2.large"
  number_of_nodes         = 1
  publicly_accessible     = false

  vpc_security_group_ids  = [aws_security_group.redclustersg.id]
  cluster_subnet_group_name = aws_redshift_subnet_group.redclustersubnetgroup.name
}

resource "aws_security_group" "redclustersg" {
  name_prefix = "my-redshift-sg"
}

resource "aws_redshift_subnet_group" "redclustersubnetgroup" {
  name       = "my-redshift-subnet-group"
  subnet_ids = aws_subnet.privatesubnet.id
}


