FROM flower7c3/debian:jessie

### install node and yarn
RUN DEBIAN_FRONTEND="noninteractive" \
    curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-key adv --keyserver pgp.mit.edu --recv D101F7899D41F3C3 \
    && echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y --fix-missing \
    	ruby ruby-dev \
        nodejs \
        yarn \
        build-essential

### install gulp
RUN DEBIAN_FRONTEND="noninteractive" \
    gem install compass \
    && npm install --global gulp gulp-cli node-gyp marked compass

WORKDIR /var/www/domains
