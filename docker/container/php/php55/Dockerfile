FROM php:5.5-apache

### install base programs
RUN DEBIAN_FRONTEND="noninteractive" apt-get update \
    && apt-get install -y --fix-missing \
        libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libpng12-dev libicu-dev \
        locales \
        vim mc wget curl git \
        zip python

### install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === 'aa96f26c2b67226a324c27919f1eb05f21c248b987e6195cad9690d5c1ff713d53020a02ac8c217dbf90a7eacc9d141d') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php --install-dir=/bin  --filename=composer \
    && php -r "unlink('composer-setup.php');"

### install phpunit
RUN wget https://phar.phpunit.de/phpunit.phar \
    && chmod +x phpunit.phar \
    && mv phpunit.phar /usr/local/bin/phpunit



### install PHP modules
# possible php mods: bcmath bz2 calendar ctype curl dba dom enchant exif fileinfo filter ftp gd gettext gmp hash iconv imap interbase intl json ldap mbstring mcrypt mysqli oci8 odbc opcache pcntl pdo pdo_dblib pdo_firebird pdo_mysql pdo_oci pdo_odbc pdo_pgsql pdo_sqlite pgsql phar posix pspell readline recode reflection session shmop simplexml snmp soap sockets spl standard sysvmsg sysvsem sysvshm tidy tokenizer wddx xml xmlreader xmlrpc xmlwriter xsl zip
RUN yes | pecl install intl xdebug \
    && locale-gen en_US.UTF-8 && export LANG=en_US.UTF-8 && export LANG=C.UTF-8 \
    && docker-php-ext-install -j$(nproc) intl mysqli pdo_mysql opcache zip \
    && docker-php-ext-enable intl mysqli pdo_mysql opcache zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd




### configure APACHE
RUN a2enmod vhost_alias
RUN a2enmod rewrite
ADD ./apache.conf /etc/apache2/sites-available/000-default.conf
RUN ln -sf /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-enabled/000-default.conf

### configure PHP
ADD ./php.ini /usr/local/etc/php/php.ini
ADD ./xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

WORKDIR /var/www/domains
