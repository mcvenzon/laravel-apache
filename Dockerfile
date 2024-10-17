# Use the official PHP image with Apache
FROM php:8.2-apache

# Enable Apache mod_rewrite
RUN a2enmod rewrite

RUN a2enmod php

# Copy custom Apache configuration
COPY apache/000-default.conf /etc/apache2/sites-available/000-default.conf

# Set the working directory
WORKDIR /var/www/html

# Copy the Laravel application files
COPY . /var/www/html

# Install PHP extensions required by Laravel
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev && \
    docker-php-ext-configure gd --with-freetype --with-jpeg

# Set permissions
RUN chown -R www-data:www-data /var/www/html 
RUN chmod -R 755 /var/www/html

# Expose port 80
EXPOSE 80
