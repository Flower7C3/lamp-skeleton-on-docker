#!/usr/bin/env bash

cd `dirname $0`

echo "Prepare new 'docker-compose.yml' file."

rm -rf docker-compose.yml
source "./docker/_config.sh"
if [ -f "./docker/_config.local.sh" ]; then
	source "./docker/_config.local.sh"
fi
echo -e "$(eval "echo -e \"`<./docker/docker-compose.tpl.yml`\"")" > ./docker-compose.yml
echo -e "$(eval "echo -e \"`<./docker/container/debian/debian-jessie/docker-compose.service.yml`\"")" >> ./docker-compose.yml
echo -e "$(eval "echo -e \"`<./docker/container/nginx/proxy/docker-compose.service.yml`\"")" >> ./docker-compose.yml
for i in "${!CONTAINER[@]}"; do
	containerPath=$i
	containerStatus=${CONTAINER[$i]}
	if [[ "$containerStatus" == "enabled" ]]; then
		serviceName=$i
		echo -e "$(eval "echo -e \"`<./docker/container/$serviceName/docker-compose.service.yml`\"")" >> ./docker-compose.yml
	fi
done
