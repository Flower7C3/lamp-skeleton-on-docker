FROM debian:jessie

### install base
RUN DEBIAN_FRONTEND="noninteractive" \
    && apt-get update \
    && apt-get install -y --fix-missing \
        vim mc wget curl git \
        libpng-dev

### install node and yarn
RUN DEBIAN_FRONTEND="noninteractive" \
    curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && apt-key adv --keyserver pgp.mit.edu --recv D101F7899D41F3C3 \
    && echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y --fix-missing \
        nodejs \
        build-essential \
        yarn

### install gulp
RUN DEBIAN_FRONTEND="noninteractive" \
    yarn global add \
        gulp gulp-cli \
        node-gyp marked

WORKDIR /var/www/domains
