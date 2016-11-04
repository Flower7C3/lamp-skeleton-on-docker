#!/usr/bin/env bash

cd `dirname $0`

echo "Prepare new 'docker-compose.yml' file."

rm -rf docker-compose.yml
source "./docker/_config.sh"
echo -e "$(eval "echo -e \"`<./docker/docker-compose.tpl.yml`\"")" > ./docker-compose.yml
