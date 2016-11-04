FROM flower7c3/debian:jessie

### install node and yarn
RUN DEBIAN_FRONTEND="noninteractive" \
    curl -sL https://deb.nodesource.com/setup_4.x | bash - \
    && apt-get update \
    && apt-get install -y --fix-missing \
        nodejs \
        build-essential

### install gulp
RUN DEBIAN_FRONTEND="noninteractive" \
    npm install --global gulp gulp-cli node-gyp marked

WORKDIR /var/www/domains
