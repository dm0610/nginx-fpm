FROM php:7.2-fpm

RUN apt-get update -y \
    && apt-get install -y nginx

ENV PHP_CPPFLAGS="$PHP_CPPFLAGS -std=c++11"

RUN docker-php-ext-install pdo_mysql \
    && docker-php-ext-install opcache \
    && apt-get install libicu-dev -y \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && apt-get remove libicu-dev icu-devtools -y

COPY nginx-site.conf /etc/nginx/sites-enabled/default
COPY entrypoint.sh /etc/entrypoint.sh

COPY index.php /var/www/mysite/

WORKDIR /var/www/mysite

EXPOSE 80 443

ENTRYPOINT ["/etc/entrypoint.sh"]