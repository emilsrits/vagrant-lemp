#!/bin/bash

sudo export DEBIAN_FRONTEND=noninteractive

echo "Provisioning virtual machine..."

echo "Updating apt-get..."
sudo apt-get update > /dev/null

# Base utilities
echo "Installing base utilities..."
sudo apt-get install -qq unzip curl git > /dev/null

# Install basic LEMP stack
# NGINX
echo "Installing NGINX..."
# sudo add-apt-repository -y ppa:nginx/stable > /dev/null
# sudo apt-get update > /dev/null
sudo apt-get install -y nginx > /dev/null
# PHP
echo "Installing PHP..."
sudo add-apt-repository -y ppa:ondrej/php > /dev/null
sudo apt-get update > /dev/null
# PHP Extensions
echo "Installing PHP extensions..."
sudo apt-get install -y php7.0-fpm php7.0-mysql php7.0-cli php7.0-mcrypt php7.0-curl php7.0-gd php7.0-intl php7.0-xsl php7.0-zip php7.0-mbstring > /dev/null

# MySQL
echo "Preparing MySQL..."
sudo apt-get install -y debconf-utils > /dev/null
# sudo wget http://dev.mysql.com/get/mysql-apt-config_0.8.1-1_all.deb > /dev/null

# echo mysql-apt-config mysql-apt-config/repo-distro select ubuntu | debconf-set-selections
# echo mysql-apt-config mysql-apt-config/repo-codename select trusty64 | debconf-set-selections
# echo mysql-apt-config mysql-apt-config/select-server select mysql-5.7 | debconf-set-selections
# echo mysql-community-server mysql-community-server/root-pass password root | debconf-set-selections
# echo mysql-community-server mysql-community-server/re-root-pass password root | debconf-set-selections

# sudo dpkg -i mysql-apt-config_0.8.1-1_all.deb > /dev/null

sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password root"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password root"

# Install MySQL
echo "Installing MySQL..."
sudo apt-get update > /dev/null
sudo apt-get install -y mysql-server > /dev/null

# NGINX config
echo "Configuring Nginx..."
sudo cp /var/www/provision/config/nginx_vhost /etc/nginx/sites-available/nginx_vhost > /dev/null
sudo ln -s /etc/nginx/sites-available/nginx_vhost /etc/nginx/sites-enabled/ > /dev/null

sudo cp /var/www/provision/config/magento.conf /etc/nginx/sites-available/magento.conf > /dev/null
sudo ln -s /etc/nginx/sites-available/magento.conf /etc/nginx/sites-enabled/ > /dev/null

sudo rm /etc/nginx/sites-available/default > /dev/null
sudo rm /etc/nginx/sites-enabled/default > /dev/null

# Restarting NGINX for config to take effect
echo "Restarting Nginx..."
sudo service nginx restart > /dev/null