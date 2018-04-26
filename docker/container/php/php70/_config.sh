#!/usr/bin/env bash

PHP70_VIRTUAL_HOST=('php70.127.0.0.1.xip.io')
for ip in "${HOST_IPS[@]}"
do
	PHP70_VIRTUAL_HOST+=('*.php70.'$ip'.xip.io' '*.php70.172.19.0.7.xip.io')
done
PHP70_VIRTUAL_HOSTS=$(IFS=, eval 'echo "${PHP70_VIRTUAL_HOST[*]}"')
echo "PHP70_VIRTUAL_HOSTS=${PHP70_VIRTUAL_HOSTS}" >> ${docker_env_file}
