FROM php:7.4-apache

MAINTAINER Jeff Moser

RUN apt-get update && \
    apt-get install -y apt-utils freetds-dev libpng-dev zlib1g-dev libmcrypt-dev libldb-dev libldap2-dev ssl-cert && \
    rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install mysqli pdo pdo_mysql

RUN a2enmod rewrite 

COPY ./services/apache /etc/apache2

COPY ./apps /var/www

RUN a2enmod rewrite &&\
    a2dissite 000-default &&\
    a2ensite rebeccamoser.local.conf &&\
    service apache2 restart

