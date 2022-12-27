#!/bin/bash

##### Variables declaration #####
WELCOME_MSG="Welcome to the website deployment script"
PACKAGES="wget unzip httpd"
WEB_SERVER_SERVICE="httpd"
TEMP_DIR="/var/webfiles"
TEMPLATE_URL="https://www.tooplate.com/zip-templates/2132_clean_work.zip"
ARCHIVED_WEBSITE="2132_clean_work.zip"
UNARCHIVED_WEBSITE="2132_clean_work/"
WEB_SRV_DIR="/var/www/html"
WEB_SRV_IP="http://`ip a | grep -i 192.168 | awk '{print $2}' | awk -F/ '{print $1}'`:80"
NOWHERE="/dev/null"

echo "####################"
echo
echo $WELCOME_MSG
echo
echo "####################"
echo

echo "####################"
echo
echo "Downloading required packages"
echo
echo "####################"
sudo yum install $PACKAGES -y > $NOWHERE
echo

echo "####################"
echo
echo "Starting and enabling HTTPD server"
echo
echo "####################"
sudo systemctl start $WEB_SERVER_SERVICE > $NOWHERE
sudo systemctl enable $WEB_SERVER_SERVICE > $NOWHERE
echo

echo "####################"
echo
echo "Creating temporary directory"
echo
echo "####################"
mkdir -p $TEMP_DIR > $NOWHERE
echo

echo "####################"
echo
echo "Downloading website template"
echo
echo "####################"
cd $TEMP_DIR > $NOWHERE
wget $TEMPLATE_URL > $NOWHERE
echo

echo "####################"
echo
echo "Deploying Website"
echo
echo "####################"
unzip $ARCHIVED_WEBSITE > $NOWHERE
sudo cp -r $UNARCHIVED_WEBSITE* $WEB_SRV_DIR > $NOWHERE
echo

echo "####################"
echo
echo "Restarting HTTPD server"
echo
echo "####################"
sudo systemctl restart $WEB_SERVER_SERVICE > $NOWHERE
echo

echo "####################"
echo
echo "Cleaning up temporary files"
echo
echo "####################"
rm -rf $TEMP_DIR > $NOWHERE
echo

echo "####################"
echo
echo "Printing HTTPD service status"
echo
echo "####################"
systemctl status $WEB_SERVER_SERVICE
echo

echo "####################"
echo
echo "Listing WEB server directory files"
echo
echo "####################"
ls $WEB_SRV_DIR
echo

echo "####################"
echo
echo "Script completed, you can now access your new website via $WEB_SRV_IP"
echo
echo "####################"

