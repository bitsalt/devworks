FROM php:7.4-fpm

RUN apt update && apt upgrade -y \
    zlib1g-dev libpng-dev \
    libzip-dev\
    && rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-install pdo_mysql bcmath gd zip
#    mysqli tokenizer bcmath opcache \
#    pcntl gd mbstring exif