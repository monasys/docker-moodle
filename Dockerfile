FROM bitnami/moodle:4

RUN mv /opt/bitnami/php/etc/php.ini-development /opt/bitnami/php/etc/php.ini

RUN install_packages vim build-essential autoconf \
    && pecl install xdebug
