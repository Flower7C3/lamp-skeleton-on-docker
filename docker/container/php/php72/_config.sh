#!/usr/bin/env bash

PHP72_VIRTUAL_HOST=('php72.127.0.0.1.xip.io')
for ip in "${HOST_IPS[@]}"
do
	PHP72_VIRTUAL_HOST+=('*.php72.'$ip'.xip.io' '*.php72.172.19.0.7.xip.io')
done
PHP72_VIRTUAL_HOSTS=$(IFS=, eval 'echo "${PHP72_VIRTUAL_HOST[*]}"')
echo "PHP72_VIRTUAL_HOSTS=${PHP72_VIRTUAL_HOSTS}" >> ${docker_env_file}
