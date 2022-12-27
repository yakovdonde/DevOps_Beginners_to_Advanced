#!/bin/bash

echo "####################"
echo
echo "Welcome to the website deployment script"
echo
echo "####################"
echo

echo "####################"
echo
echo "Downloading required packages"
echo
echo "####################"
sudo yum install wget unzip httpd -y
echo

echo "####################"
echo
echo "Starting and enabling HTTPD server"
echo
echo "####################"
sudo systemctl start httpd
sudo systemctl enable httpd
echo

echo "####################"
echo
echo "Creating temporary directory"
echo
echo "####################"
mkdir -p /tmp/webfiles
echo

echo "####################"
echo
echo "Downloading website template"
echo
echo "####################"
cd /tmp/webfiles
wget https://www.tooplate.com/zip-templates/2132_clean_work.zip
echo

echo "####################"
echo
echo "Deploying Website"
echo
echo "####################"
unzip 2132_clean_work.zip
sudo cp -r 2132_clean_work/* /var/www/html
echo

echo "####################"
echo
echo "Restarting HTTPD server"
echo
echo "####################"
sudo systemctl restart httpd
echo

echo "####################"
echo
echo "Cleaning up temporary files"
echo
echo "####################"
rm -rf /tmp/webfiles
echo

echo "####################"
echo
echo "Printing HTTPD service status"
echo
echo "####################"
systemctl status httpd
echo

echo "####################"
echo
echo "Listing WEB server directory files"
echo
echo "####################"
ls /var/www/html/
echo

echo "####################"
echo
echo "Script completed, you can now access your new website via http://`ip a | grep -i 192.168 | awk '{print $2}' | awk -F/ '{print $1}'`:80"
echo
echo "####################"

