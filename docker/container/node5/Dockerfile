FROM debian:jessie

### install node
RUN DEBIAN_FRONTEND="noninteractive" apt-get update \
    && apt-get -y install curl \
    && curl -sL https://deb.nodesource.com/setup_5.x | bash - \
    && apt-get install -y \
        build-essential nodejs \
    && npm install --global gulp gulp-cli node-gyp marked
