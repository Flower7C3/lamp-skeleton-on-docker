#!/usr/bin/env bash

cd `dirname $0`

echo "Prepare new 'docker-compose.yml' file."

rm -rf docker-compose.yml docker-sync.yml
source "./docker/_config.sh"
if [ -f "./docker/_config.local.sh" ]; then
	source "./docker/_config.local.sh"
fi
echo -e "$(eval "echo -e \"`<./docker/docker-sync.tpl.yml`\"")" > ./docker-sync.yml
echo -e "$(eval "echo -e \"`<./docker/docker-compose.tpl.yml`\"")" > ./docker-compose.yml
echo -e "$(eval "echo -e \"`<./docker/docker-compose.volumes.tpl.yml`\"")" >> ./docker-compose.yml
for i in "${!CONTAINER[@]}"; do
	containerPath=$i
	containerStatus=${CONTAINER[$i]}
	if [[ "$containerStatus" == "enabled" ]]; then
		serviceName=$i
		if [[ -f "./docker/container/$serviceName/docker-compose.volumes.tpl.yml" ]]; then
			echo -e "$(eval "echo -e \"`<./docker/container/$serviceName/docker-compose.volumes.tpl.yml`\"")" >> ./docker-compose.yml
		fi
	fi
done
echo -e "$(eval "echo -e \"`<./docker/docker-compose.services.tpl.yml`\"")" >> ./docker-compose.yml
echo -e "$(eval "echo -e \"`<./docker/container/debian/debian-jessie/docker-compose.services.tpl.yml`\"")" >> ./docker-compose.yml
echo -e "$(eval "echo -e \"`<./docker/container/nginx/proxy/docker-compose.services.tpl.yml`\"")" >> ./docker-compose.yml
for i in "${!CONTAINER[@]}"; do
	containerPath=$i
	containerStatus=${CONTAINER[$i]}
	if [[ "$containerStatus" == "enabled" ]]; then
		serviceName=$i
		if [[ -f "./docker/container/$serviceName/docker-compose.services.tpl.yml" ]]; then
			echo -e "$(eval "echo -e \"`<./docker/container/$serviceName/docker-compose.services.tpl.yml`\"")" >> ./docker-compose.yml
		fi
		if [[ -f "./docker/container/$serviceName/docker-sync.syncs.tpl.yml" ]]; then
			echo -e "$(eval "echo -e \"`<./docker/container/$serviceName/docker-sync.syncs.tpl.yml`\"")" >> ./docker-sync.yml
		fi
	fi
done
