FROM php:8.4-apache

RUN a2enmod rewrite

RUN apt-get update && apt-get install -y --no-install-recommends \
    nano vim wget unzip zip \
    libzip-dev zlib1g-dev \
    libicu-dev \
    libpng-dev libjpeg62-turbo-dev libfreetype6-dev \
    imagemagick libmagickwand-dev \
    default-mysql-client \
    cron \
    pkg-config libonig-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
    pdo_mysql mysqli intl zip opcache gd \
    mbstring exif bcmath \
    && pecl install imagick xdebug \
    && docker-php-ext-enable imagick xdebug \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
ENV COMPOSER_ALLOW_SUPERUSER=1
