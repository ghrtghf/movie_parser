FROM php:8.3-fpm-bookworm

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libicu-dev \
    libpq-dev \
    libzip-dev \
    && docker-php-ext-install -j$(nproc) intl pdo_pgsql zip opcache \
    && pecl channel-update pecl.php.net \
    && yes '' | pecl install mongodb xdebug \
    && docker-php-ext-enable mongodb xdebug \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html
