#!/usr/bin/env bash

cd `dirname $0`

echo "Prepare new 'docker-compose.yml' file."

rm -rf docker-compose.yml docker-sync.yml
source "./docker/_config.sh"
if [ -f "./docker/_config.local.sh" ]; then
	source "./docker/_config.local.sh"
fi
source "./docker/_config_www.sh"

echo -e "$(eval "echo -e \"`<./docker/docker-compose.tpl.yml`\"")" > ./docker-compose.yml

echo "Build networks..."
echo -e "$(eval "echo -e \"`<./docker/docker-compose.networks.tpl.yml`\"")" >> ./docker-compose.yml

if [[ "$DOCKER_SYNC_STRATEGY" != "" ]]; then
	echo "Build volumes..."
	echo -e "$(eval "echo -e \"`<./docker/docker-sync.tpl.yml`\"")" > ./docker-sync.yml
	echo -e "$(eval "echo -e \"`<./docker/docker-compose.volumes.tpl.yml`\"")" >> ./docker-compose.yml
	for i in "${!CONTAINER[@]}"; do
		containerPath=$i
		containerStatus=${CONTAINER[$i]}
		if [[ "$containerStatus" == "enabled" ]]; then
			serviceName=$i
			if [ -f "./docker/container/$serviceName/_config.sh" ]; then
				source "./docker/container/$serviceName/_config.sh"
			fi
			if [[ -f "./docker/container/$serviceName/docker-compose.volumes.tpl.yml" ]]; then
				echo -e "$(eval "echo -e \"`<./docker/container/$serviceName/docker-compose.volumes.tpl.yml`\"")" >> ./docker-compose.yml
			fi
		fi
	done
fi

echo "Build services..."
echo -e "$(eval "echo -e \"`<./docker/docker-compose.services.tpl.yml`\"")" >> ./docker-compose.yml
for i in "${!CONTAINER[@]}"; do
	containerPath=$i
	containerStatus=${CONTAINER[$i]}
	if [[ "$containerStatus" == "enabled" ]]; then
		serviceName=$i
		if [ -f "./docker/container/$serviceName/_config.sh" ]; then
			source "./docker/container/$serviceName/_config.sh"
		fi
		if [[ -f "./docker/container/$serviceName/docker-compose.services.tpl.yml" ]]; then
			echo -e "$(eval "echo -e \"`<./docker/container/$serviceName/docker-compose.services.tpl.yml`\"")" >> ./docker-compose.yml
		fi
		if [[ "$DOCKER_SYNC_STRATEGY" != "" ]]; then
			if [[ -f "./docker/container/$serviceName/docker-sync.syncs.tpl.yml" ]]; then
				echo -e "$(eval "echo -e \"`<./docker/container/$serviceName/docker-sync.syncs.tpl.yml`\"")" >> ./docker-sync.yml
			fi
		fi
	fi
done

if [[ "$DOCKER_SYNC_STRATEGY" != "" ]]; then
	echo "Done. Now you can execute 'docker-sync-stack start' command."
else
	echo "Done. Now you can execute 'docker-compose up -d' command."
fi