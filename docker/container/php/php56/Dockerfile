FROM php:5.6-apache

### install base programs
RUN DEBIAN_FRONTEND="noninteractive" apt-get update \
    && apt-get install -y --fix-missing \
        libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libpng12-dev libicu-dev \
        locales \
        vim mc wget curl git \
        zip python \
        libsasl2-dev

### install composer
RUN echo "$(curl -sS https://composer.github.io/installer.sig) -" > composer-setup.php.sig \
    && curl -sS https://getcomposer.org/installer | tee composer-setup.php | sha384sum -c composer-setup.php.sig \
    && php composer-setup.php -- --install-dir=/bin --filename=composer

### install phpunit
RUN wget https://phar.phpunit.de/phpunit.phar \
    && chmod +x phpunit.phar \
    && mv phpunit.phar /usr/local/bin/phpunit



### install PHP modules
# possible php mods: bcmath bz2 calendar ctype curl dba dom enchant exif fileinfo filter ftp gd gettext gmp hash iconv imap interbase intl json ldap mbstring mcrypt mysqli oci8 odbc opcache pcntl pdo pdo_dblib pdo_firebird pdo_mysql pdo_oci pdo_odbc pdo_pgsql pdo_sqlite pgsql phar posix pspell readline recode reflection session shmop simplexml snmp soap sockets spl standard sysvmsg sysvsem sysvshm tidy tokenizer wddx xml xmlreader xmlrpc xmlwriter xsl zip
RUN apt-get update \
  && apt-get install -y \
    imagemagick libmagickwand-dev libmagickcore-dev \
    libmcrypt-dev libcurl4-gnutls-dev libicu-dev libxslt-dev libssl-dev
RUN yes | pecl install \
        intl xdebug redis mongodb mongo \
    && docker-php-ext-enable redis mongo mongodb
RUN locale-gen en_US.UTF-8 && export LANG=en_US.UTF-8 && export LANG=C.UTF-8 \
    && docker-php-ext-install -j$(nproc) intl mysqli pdo_mysql opcache zip curl bcmath mcrypt iconv exif json session xmlrpc xsl \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

# install java for assetic
RUN DEBIAN_FRONTEND="noninteractive" apt-get update \
    && apt-get install -y --fix-missing \
        default-jre

### install imagick
#RUN DEBIAN_FRONTEND="noninteractive" apt-get update \
#    && apt-get install --fix-missing -y libmagickwand-dev imagemagick \
#    && yes | pecl install imagick
#RUN echo "extension=imagick.so" >> /usr/local/etc/php/php.ini



### configure APACHE
RUN a2enmod vhost_alias
RUN a2enmod rewrite
ADD ./apache.conf /etc/apache2/sites-available/000-default.conf
RUN ln -sf /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-enabled/000-default.conf

### configure PHP
ADD ./php.ini /usr/local/etc/php/php.ini
ADD ./xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

WORKDIR /var/www/domains
