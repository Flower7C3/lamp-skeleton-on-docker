#!/usr/bin/env bash

PHP71_DOCKER_NETWORK_IP=192.168.33.71

PHP71_VIRTUAL_HOST=('php71.127.0.0.1.xip.io')
for ip in "${HOST_IPS[@]}"
do
	PHP71_VIRTUAL_HOST+=('*.php71.'$ip'.xip.io')
done
PHP71_VIRTUAL_HOSTS=$(IFS=, eval 'echo "${PHP71_VIRTUAL_HOST[*]}"')
