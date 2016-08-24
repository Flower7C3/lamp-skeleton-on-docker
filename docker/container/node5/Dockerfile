FROM debian:jessie

### install node
RUN DEBIAN_FRONTEND="noninteractive" apt-get update \
    && apt-get -y install vim wget curl git \
    && curl -sL https://deb.nodesource.com/setup_5.x | bash - \
    && apt-get install -y \
        build-essential nodejs \
    && npm install --global gulp gulp-cli node-gyp marked

WORKDIR /var/www/domains
