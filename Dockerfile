FROM php:8.2-apache

# Prepare install
RUN apt-get update --fix-missing
RUN apt-get install -y build-essential libssl-dev zlib1g-dev libpng-dev libjpeg-dev libfreetype6-dev libxml2-dev

# Install essentials
RUN apt-get install -my gnupg curl

# Install zip extension
RUN apt-get install -y libzip-dev && docker-php-ext-install zip

# Install mysql extension
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Install gd extension
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd

RUN docker-php-ext-install -j$(nproc) soap xml opcache intl exif

# Xdebug
RUN pecl install -f xdebug && docker-php-ext-enable xdebug
COPY ./assets/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/local/bin

# Project-specific ini settings
COPY ./assets/php.ini.local /usr/local/etc/php/php.ini

RUN a2enmod rewrite
RUN a2enmod headers

# NVM and Node.js
ENV NODE_VERSION 20.11.0
ENV NVM_DIR /usr/local/nvm
RUN mkdir $NVM_DIR
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.39.2/install.sh | bash
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
RUN echo "source $NVM_DIR/nvm.sh && \
    nvm install $NODE_VERSION && \
    nvm alias default $NODE_VERSION && \
    nvm use default" | bash

# Npm
RUN npm install -g npm

# Grunt
RUN npm install -g --save-dev grunt grunt-cli grunt-contrib-watch grunt-contrib-uglify grunt-contrib-less grunt-load-gruntfile grunt-eslint grunt-babel grunt-jsdoc grunt-sass grunt-stylelint grunt-rollup
