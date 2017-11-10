#!/usr/bin/env bash

PHP70_DOCKER_NETWORK_IP=192.168.33.70

PHP70_VIRTUAL_HOST=('php70.127.0.0.1.xip.io')
for ip in "${HOST_IPS[@]}"
do
	PHP70_VIRTUAL_HOST+=('*.php70.'$ip'.xip.io')
done
PHP70_VIRTUAL_HOSTS=$(IFS=, eval 'echo "${PHP70_VIRTUAL_HOST[*]}"')
