## config.sh


#!/bin/bash

# Set Variables for Ubuntu
PACKAGE="apache2"
SVC="apache2"

echo "Running Setup on Ubuntu"
# Installing Apache
echo "########################################"
echo "Installing packages."
echo "########################################"
sudo apt update
sudo apt install $PACKAGE -y > /dev/null
echo

# Start & Enable Apache Service
echo "########################################"
echo "Start & Enable HTTPD Service"
echo "########################################"
sudo systemctl start $SVC
sudo systemctl enable $SVC
echo

# Add a custom message to the default index.html
echo "########################################"
echo "Adding custom message to index.html"
echo "########################################"
echo "Our application is successfully configured thumbs up" > /var/www/html/index.html
echo

echo "Apache installation and setup complete."
