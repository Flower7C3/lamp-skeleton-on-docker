#!/usr/bin/env bash

PHP55_VIRTUAL_HOST=('php55.127.0.0.1.xip.io')
for ip in "${HOST_IPS[@]}"
do
	PHP55_VIRTUAL_HOST+=('*.php55.'$ip'.xip.io')
done
PHP55_VIRTUAL_HOSTS=$(IFS=, eval 'echo "${PHP55_VIRTUAL_HOST[*]}"')
echo "PHP55_VIRTUAL_HOSTS=${PHP55_VIRTUAL_HOSTS}" >> ${docker_env_file}
