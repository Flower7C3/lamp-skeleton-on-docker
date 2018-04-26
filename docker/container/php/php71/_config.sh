#!/usr/bin/env bash

PHP71_VIRTUAL_HOST=('php71.127.0.0.1.xip.io')
for ip in "${HOST_IPS[@]}"
do
	PHP71_VIRTUAL_HOST+=('*.php71.'$ip'.xip.io' '*.php71.172.19.0.7.xip.io')
done
PHP71_VIRTUAL_HOSTS=$(IFS=, eval 'echo "${PHP71_VIRTUAL_HOST[*]}"')
echo "PHP71_VIRTUAL_HOSTS=${PHP71_VIRTUAL_HOSTS}" >> ${docker_env_file}
