FROM flower7c3/debian:jessie

### install node and yarn
RUN DEBIAN_FRONTEND="noninteractive" \
    curl -sL https://deb.nodesource.com/setup_5.x | bash - \
    && apt-get update \
    && apt-get install -y --fix-missing \
    	ruby ruby-dev \
        nodejs \
        build-essential

### install gulp
RUN DEBIAN_FRONTEND="noninteractive" \
    gem install compass \
    npm install --global gulp gulp-cli node-gyp marked compass

WORKDIR /var/www/domains
