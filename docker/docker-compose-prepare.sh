#!/usr/bin/env bash

cd `dirname $0`

# read configuration
source "_config.sh"

# create docker compose
rm -rf docker-compose.yml
echo -e "$(eval "echo -e \"`<docker-compose.tpl.yml`\"")" > docker-compose.yml

# execute docker compose
docker-compose $@
