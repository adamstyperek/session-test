# docker/php/Dockerfile

FROM php:8.2-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libxml2-dev \
    libxslt-dev \
    libicu-dev \
    libonig-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install pdo pdo_mysql mysqli zip intl xsl mbstring xml opcache

# Install Redis extension
RUN pecl install redis && docker-php-ext-enable redis

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Configure Apache
RUN a2enmod rewrite
COPY docker/php/000-default.conf /etc/apache2/sites-available/000-default.conf

WORKDIR /var/www

# Optional: Set timezone
RUN ln -snf /usr/share/zoneinfo/Europe/Warsaw /etc/localtime && echo Europe/Warsaw > /etc/timezone

# Install dependencies
COPY composer.json composer.lock ./
RUN composer install --no-interaction --no-scripts

# Copy the rest of the application
COPY . .

# Install netcat for the wait script
RUN apt-get install -y netcat-traditional

# Create entrypoint script
COPY docker/php/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Set permissions
RUN chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www \
    && chmod -R 777 /var/www/var/cache /var/www/var/log

CMD ["/usr/local/bin/docker-entrypoint.sh"]
