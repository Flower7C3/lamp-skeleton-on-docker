#!/usr/bin/env bash

cd `dirname $0`

echo "Prepare 'docker-compose.yml' file"

echo "Remove old file."
rm -rf docker-compose.yml

echo "Create new file."
source "./docker/_config.sh"
echo -e "$(eval "echo -e \"`<./docker/docker-compose.tpl.yml`\"")" > ./docker-compose.yml

mv ./docker-compose.yml ./docker/docker-compose.yml

echo "Done."