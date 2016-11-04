FROM debian:jessie

### install base programs
RUN DEBIAN_FRONTEND="noninteractive" apt-get update

RUN apt-get install -y --fix-missing \
        libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libpng12-dev libicu-dev

RUN apt-get install -y --fix-missing \
        locales

RUN apt-get install -y --fix-missing \
        vim \
        mc \
        wget curl \
        git

RUN apt-get install -y --fix-missing \
        zip python
