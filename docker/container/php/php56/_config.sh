#!/usr/bin/env bash

PHP56_DOCKER_NETWORK_IP=192.168.33.56

PHP56_VIRTUAL_HOST=('php56.127.0.0.1.xip.io')
for ip in "${HOST_IPS[@]}"
do
	PHP56_VIRTUAL_HOST+=('*.php56.'$ip'.xip.io')
done
PHP56_VIRTUAL_HOSTS=$(IFS=, eval 'echo "${PHP56_VIRTUAL_HOST[*]}"')
