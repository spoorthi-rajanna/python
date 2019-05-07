#!/bin/bash

sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y
sudo yum-config-manager --enable rhui-REGION-rhel-server-extras
sudo yum install -y docker-ce
sudo systemctl enable docker
sudo systemctl start docker
docker -v
sudo docker pull sonatype/nexus3
sudo docker run -d -p 8081:8081 --name nexus sonatype/nexus3
sudo docker pull sonarqube
sudo docker run -d --name sonarqube -p 9000:9000 sonarqube
