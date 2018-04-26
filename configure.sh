#!/usr/bin/env bash

cd `dirname $0`

echo "Read configuration..."
source "./docker/_config.sh"
if [ -f "./docker/_config.local.sh" ]; then
	source "./docker/_config.local.sh"
fi

echo "Prepare new '${docker_env_file}' file..."
rm -rf ${docker_env_file}
cat "./docker/template/.env" > ${docker_env_file}
echo "; NETWORK" >> ${docker_env_file}
echo "XDEBUG_HOST=${XDEBUG_HOST}" >> ${docker_env_file}
echo "DNS_IP=${DNS_IP}" >> ${docker_env_file}
echo "; COMMON" >> ${docker_env_file}
echo "VOLUME_BASH_HISTORY_LOCAL_PATH=${VOLUME_BASH_HISTORY_LOCAL_PATH}" >> ${docker_env_file}
echo "VOLUME_BASH_HISTORY_TARGET=${VOLUME_BASH_HISTORY_TARGET}" >> ${docker_env_file}
echo "VOLUME_SSH_LOCAL_PATH=${VOLUME_SSH_LOCAL_PATH}" >> ${docker_env_file}
echo "VOLUME_SSH_TARGET=${VOLUME_SSH_TARGET}" >> ${docker_env_file}
echo "VOLUME_TOOLS_LOCAL_PATH=${VOLUME_TOOLS_LOCAL_PATH}" >> ${docker_env_file}
echo "VOLUME_TOOLS_TARGET=${VOLUME_TOOLS_TARGET}" >> ${docker_env_file}
echo "; PROJECTS" >> ${docker_env_file}
echo "VOLUME_PROJECTS_LOCAL_PATH=${VOLUME_PROJECTS_LOCAL_PATH}" >> ${docker_env_file}
echo "VOLUME_PROJECTS_TARGET=${VOLUME_PROJECTS_TARGET}" >> ${docker_env_file}
echo "VOLUME_DOMAINS_LOCAL_PATH=${VOLUME_DOMAINS_LOCAL_PATH}" >> ${docker_env_file}
echo "VOLUME_DOMAINS_TARGET=${VOLUME_DOMAINS_TARGET}" >> ${docker_env_file}
echo "; CONTAINERS" >> ${docker_env_file}

echo "Prepare new '${docker_compose_file}' file..."
rm -rf ${docker_compose_file}
cat "./docker/template/docker-compose.yml" > ${docker_compose_file}
for i in "${!CONTAINER[@]}"; do
	containerPath=$i
	containerStatus=${CONTAINER[$i]}
	if [[ "$containerStatus" == "enabled" ]]; then
		serviceName=$i
		if [ -f "./docker/container/$serviceName/_config.sh" ]; then
			source "./docker/container/$serviceName/_config.sh"
		fi
		if [ -f "./docker/container/$serviceName/docker.tpl.env" ]; then
			cat "./docker/container/$serviceName/docker.tpl.env" >> ${docker_env_file}
		fi
		if [[ -f "./docker/container/$serviceName/docker-compose.services.tpl.yml" ]]; then
			cat "./docker/container/$serviceName/docker-compose.services.tpl.yml" >> ${docker_compose_file}
		fi
	fi
done

echo "Done. Now you can execute 'docker-compose up -d' command."
docker-compose up -d
