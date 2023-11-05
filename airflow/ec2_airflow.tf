resource "aws_instance" "airflowinstance" {
  ami           = "ami-0e83be366243f524a" 
  instance_type = "t2.micro" 
  key_name      = "sajal-key-pair"  
  security_groups = [aws_security_group.airflowsg.id]
  subnet_id     = aws_subnet.privatesubnet.id
  user_data = <<EOF
   #!/bin/bash

    # Install pwgen
    sudo apt install pwgen

    # Generate a random password for the Airflow user
    airflow_user_password=$(pwgen -s 12)

    # Store the password in the password manager
    pw add airflow-user "$airflow_user_password"

    # Update package manager
    sudo apt update -y

    # Install Python 3.6 or later
    sudo apt install python3.6 -y

    # Install Pip
    sudo apt install python3-pip -y

    # Install Airflow and its dependencies
    pip install apache-airflow[amazon]

    # Create an Airflow user
    sudo useradd -m -s /bin/bash airflow

    # Set the password for the Airflow user using the password manager
    sudo pw unlock --passphrase 0
    sudo pw set airflow-user airflow_user_password
    sudo pw lock

    # Initialize the Airflow database
    airflow initdb

    # Start the Airflow webserver
    airflow webserver

    # Start the Airflow scheduler
    airflow scheduler

    EOF
    
        

  tags = {
      Name = "airflow-instance"
  }
    
}
resource "aws_security_group" "airflowsg" {
  name_prefix = "my-airflow-sg"

}


