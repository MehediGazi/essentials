#install PHP 8.1, PHP extensions, Composer 2.2.7, Node 14.18.1, CodeDeploy Agent, SSL mods and Bengali font
#! /bin/sh

echo $(date '+%d/%m/%Y %H:%M:%S')

#Install Apache2
echo 'Installing Apache2'
sudo apt install apache2 -y

#Install PHP 8.1
echo 'Installing PHP 8.1'
sudo apt update
sudo apt install lsb-release ca-certificates apt-transport-https software-properties-common -y
sudo add-apt-repository ppa:ondrej/php -y

sudo apt update
sudo apt install php8.1 -y

#PHP extensions
echo 'Installing PHP extensions'
sudo apt install php8.1-curl php8.1-dom php8.1-gd php8.1-igbinary php8.1-mbstring php8.1-mysqli php8.1-mysqlnd php8.1-redis php8.1-SimpleXML php8.1-xml php8.1-xmlreader php8.1-xmlwriter php8.1-xsl php8.1-zip -y
#sudo apt install php8.1-newrelic php8.1-pdo_mysql -y


#Install Composer 2.2.7
echo 'Installing Composer 2.2.7'
sudo apt update
sudo apt-get install php-cli unzip zip -y
cd ~
curl -sS https://getcomposer.org/installer -o composer-setup.php
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer --version=2.2.7


#Install Node 14.18.1
echo 'Installing Node 14.18.1'
sudo apt update -y
sudo apt install curl -y
curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
sudo apt install -y nodejs
sudo npm install -g n # n tool is used to controll node version
sudo n 14.18.1

echo 'Installing Yarn and PM2'
sudo npm i -g yarn #install yarn
sudo npm install pm2 -g #install pm2

#Install ruby and codedeploy-agent
apt update
sudo apt install ruby-full #(first run 'sudo apt install ruby2.0' if  'sudo apt install ruby-full' gets an error)
cd /home/ubuntu/
wget https://aws-codedeploy-ap-southeast-1.s3.ap-southeast-1.amazonaws.com/latest/install #latest codedeploy-agent
sudo chmod +x ./install
sudo ./install auto > /tmp/logfile
sudo service codedeploy-agent status
sudo systemctl restart apache2
#**remove and reinstall codedeploy-agent if get any error
#sudo dpkg --purge codedeploy-agent

#Enable Apache mods- for SSL
sudo a2enmod ssl #enable ssl
sudo a2enmod rewrite #enable rewrite
sudo a2enmod proxy_http #enable proxy pass
sudo apachectl -t #see apache error logs
systemctl restart apache2

#Install Bengali font (Lohit)
echo 'Installing Bengali Font'
apt update
apt install fonts-lohit-beng-bengali

echo 'Successfully Installed the Dependencies'
php --version
composer --version -y
echo Node version:
node --version
echo npm version:
npm --version