##################################
# How to build the image?
#
# $> docker build -f Dockerfile -t melthaw/xdag:latest .
#
##################################
#FROM mkenney/npm:node-7-debian as builder
FROM node:8.11 as builder

LABEL maintainer "melthaw@gmail.com"

RUN apt-get update && apt-get install -y unzip && mkdir -p /var/www

ADD master.zip /var/www

RUN cd /var/www && \
    unzip ./master.zip && \
    mv openxdagpool-master openxdagpool && \
    cd openxdagpool && \
    node --version && \
    npm --version && \
    npm install && \
    npm run production

FROM php:7.2-fpm

LABEL maintainer "melthaw@gmail.com"

RUN apt-get update && apt-get install -y git unzip && mkdir -p /var/www/openxdagpool

COPY --from=builder /var/www/openxdagpool/ /var/www/openxdagpool/

RUN cd /var/www/openxdagpool && \
    ls -a && \
    mv .env.example .env && \
    chmod 777 storage && chmod -R 777 storage/* && \
    curl -sS https://getcomposer.org/installer | php && \
    ln -s /var/www/openxdagpool/composer.phar /usr/bin/composer && \
    composer config -g repo.packagist composer https://packagist.phpcomposer.com && \
    composer install && \
    php artisan key:generate
#    php artisan migrate

WORKDIR /var/www/openxdagpool

VOLUME ["/var/www/openxdagpool"]