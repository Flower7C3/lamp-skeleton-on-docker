#!/usr/bin/env bash

cd `dirname $0`

echo "Read configuration..."
docker_compose_file="./docker-compose.yml"
docker_env_file="./.env"
source "./docker/_config.sh"
if [ -f "./docker/_config.local.sh" ]; then
	source "./docker/_config.local.sh"
fi

echo "Prepare new '${docker_compose_file}' file..."
rm -rf ${docker_compose_file}
cat "./docker/docker-compose.tpl.yml" > ${docker_compose_file}
cat "./docker/docker-compose.networks.tpl.yml" >> ${docker_compose_file}
cat "./docker/docker-compose.services.tpl.yml" >> ${docker_compose_file}
for i in "${!CONTAINER[@]}"; do
	containerPath=$i
	containerStatus=${CONTAINER[$i]}
	if [[ "$containerStatus" == "enabled" ]]; then
		serviceName=$i
		if [ -f "./docker/container/$serviceName/_config.sh" ]; then
			source "./docker/container/$serviceName/_config.sh"
		fi
		if [[ -f "./docker/container/$serviceName/docker-compose.services.tpl.yml" ]]; then
			cat "./docker/container/$serviceName/docker-compose.services.tpl.yml" >> ${docker_compose_file}
		fi
	fi
done

echo "Prepare new '${docker_env_file}' file..."
rm -rf ${docker_env_file}
touch ${docker_env_file}
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
echo "; DATABASES" >> ${docker_env_file}
echo "VOLUME_MYSQL55_LOCAL_PATH=${VOLUME_MYSQL55_LOCAL_PATH}" >> ${docker_env_file}
echo "VOLUME_MYSQL56_LOCAL_PATH=${VOLUME_MYSQL56_LOCAL_PATH}" >> ${docker_env_file}
echo "VOLUME_ELASTIC1_LOCAL_PATH=${VOLUME_ELASTIC1_LOCAL_PATH}" >> ${docker_env_file}
echo "VOLUME_ELASTIC5_LOCAL_PATH=${VOLUME_ELASTIC5_LOCAL_PATH}" >> ${docker_env_file}
echo "VOLUME_MONGO3_LOCAL_PATH=${VOLUME_MONGO3_LOCAL_PATH}" >> ${docker_env_file}
echo "VOLUME_REDIS3_LOCAL_PATH=${VOLUME_REDIS3_LOCAL_PATH}" >> ${docker_env_file}
echo "; HOSTS" >> ${docker_env_file}
echo "PROXY_DEFAULT_HOST=${PROXY_DEFAULT_HOST}" >> ${docker_env_file}
echo "PHP55_VIRTUAL_HOSTS=${PHP71_VIRTUAL_HOSTS}" >> ${docker_env_file}
echo "PHP56_VIRTUAL_HOSTS=${PHP71_VIRTUAL_HOSTS}" >> ${docker_env_file}
echo "PHP70_VIRTUAL_HOSTS=${PHP71_VIRTUAL_HOSTS}" >> ${docker_env_file}
echo "PHP71_VIRTUAL_HOSTS=${PHP71_VIRTUAL_HOSTS}" >> ${docker_env_file}

echo "Done. Now you can execute 'docker-compose up -d' command."
docker-compose up -d
