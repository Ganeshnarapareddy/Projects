#!/bin/bash
# Update system and install Docker
sudo yum update -y && sudo yum install docker -y
sudo yum install polkit -y
sudo systemctl restart polkit
sudo systemctl start docker
# Start and enable Docker
sudo systemctl start docker
sudo systemctl enable docker
# Add ec2-user to Docker group and apply changes immediately
sudo usermod -aG docker ec2-user
sudo docker run -d -p 8080:80 nginx
