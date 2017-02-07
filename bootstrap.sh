#!/usr/bin/env bash


### Set script params

source /vagrant/.const

#MySQL
function install_mysql_server()
{
    debconf-set-selections <<< "mysql-server mysql-server/root_password password ${DB_PASS}"
    debconf-set-selections <<< "mysql-server mysql-server/root_password_again password ${DB_PASS}"

    apt-get -qq update
    apt-get install -y mysql-server-5.6

    mysql -u${DB_USER} -p${DB_PASS} -e "CREATE DATABASE ${DB_NAME};"
}

#WebServer
function install_webserver()
{
    add-apt-repository ppa:ondrej/php -y
    apt-get -qq update
    apt-get install -y mc curl \
                       nginx \
                       sshfs \
                       php7.0-fpm \
                       php7.0-common \
                       php7.0-cli \
                       php7.0-gd \
                       php7.0-mysql \
                       php7.0-curl \
                       php-pear \
                       php7.0-dev \
                       php7.0-mongo \
                       make \
                       openssl \
                       libssl-dev \
                       libcurl4-openssl-dev \
                       libsasl2-dev \
                       libpcre3-dev \
		               php7.0-mcrypt

    adduser vagrant www-data
}

#additional
function install_additional()
{
    apt-get -qq update
    apt-get install -y libjpeg-progs \
                       optipng \
                       gifsicle \
                       imagemagick
}

function install_adminer()
{
    wget -O /var/www/public/adminer.php https://github.com/vrana/adminer/releases/download/v4.2.5/adminer-4.2.5.php
}

install_mysql_server
install_webserver
install_additional
install_adminer
