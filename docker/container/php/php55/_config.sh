#!/usr/bin/env bash

PHP55_DOCKER_NETWORK_IP=192.168.33.55

PHP55_VIRTUAL_HOST=('php55.127.0.0.1.xip.io')
for ip in "${HOST_IPS[@]}"
do
	PHP55_VIRTUAL_HOST+=('*.php55.'$ip'.xip.io')
done
PHP55_VIRTUAL_HOSTS=$(IFS=, eval 'echo "${PHP55_VIRTUAL_HOST[*]}"')
