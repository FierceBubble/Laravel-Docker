# Change php version as needed can be found in docker hub
# https://hub.docker.com/_/php/tags?page=1&name=fpm
FROM php:7.2-fpm as php

# Arguments defined in docker-compose.yml
# Creating user to use php commands in the CLI
ARG user
ARG uid

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libzip-dev \
    -y mariadb-client

# Install PHP extensions
# Add more if needed
RUN docker-php-ext-install \
    zip \
    mysqli \
    pdo_mysql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    gd \
    && docker-php-ext-enable mysqli
    
# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Redis Caching
RUN pecl install -o -f redis \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable redis

# Installing composer into the project, preventing any error when trying to run a project without any composer installed
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Enabling user to use artisan and composer commands in the CLI
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

# Set working directory
WORKDIR /var/www

USER $user
