#!/bin/bash
sudo yum update -y
sudo yum install -y httpd git
systemctl start httpd
systemctl enable httpd
cd /var/www/html
git init
git pull https://github.com/toivjon/html5-space-invaders.git
