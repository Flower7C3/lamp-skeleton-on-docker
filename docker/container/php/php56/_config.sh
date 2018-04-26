#!/usr/bin/env bash

PHP56_VIRTUAL_HOST=('php56.127.0.0.1.xip.io')
for ip in "${HOST_IPS[@]}"
do
	PHP56_VIRTUAL_HOST+=('*.php56.'$ip'.xip.io')
done
PHP56_VIRTUAL_HOSTS=$(IFS=, eval 'echo "${PHP56_VIRTUAL_HOST[*]}"')
echo "PHP56_VIRTUAL_HOSTS=${PHP56_VIRTUAL_HOSTS}" >> ${docker_env_file}
