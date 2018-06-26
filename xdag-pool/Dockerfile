##################################
# How to build the image?
#
# $> docker build -f Dockerfile -t melthaw/xdag:latest .
#
##################################
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

FROM ubuntu:xenial

LABEL maintainer "melthaw@gmail.com"

RUN apt-get update && \
    apt-get install -y git unzip curl net-tools iputils-ping vim php7.0-bcmath php7.0-cli php7.0-common php7.0-fpm php7.0-json php7.0-mbstring php7.0-mcrypt php7.0-mysql php7.0-opcache php7.0-readline php7.0-sqlite3 php7.0-xml php7.0-zip supervisor && \
    mkdir -p /var/www/openxdagpool && \
    mkdir -p /run/php

COPY --from=builder /var/www/openxdagpool/ /var/www/openxdagpool/
COPY .env /var/www/openxdagpool/.env

RUN cd /var/www/openxdagpool && \
    chmod 777 storage && chmod -R 777 storage/* && \
    curl -sS https://getcomposer.org/installer | php && \
    ln -s /var/www/openxdagpool/composer.phar /usr/bin/composer && \
    composer config -g repo.packagist composer https://packagist.phpcomposer.com && \
    composer install && \
    php artisan key:generate
#    php artisan migrate

ADD container_files/etc/ /etc/
ADD container_files/scripts/ /

RUN chmod +x /*.sh

VOLUME ["/var/www/openxdagpool"]

WORKDIR /var/www/openxdagpool

EXPOSE 9000

ENTRYPOINT ["/docker-entrypoint.sh"]
