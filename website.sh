#!/bin/bash

# Update Machine
sudo apt update
sudo apt upgrade

# Install Apache2
sudo apt-get update
sudo apt-get install apache2 -y

# Enable SSL module and restart Apache
sudo a2enmod ssl
sudo service apache2 restart