docker_compose_file="./docker-compose.yml"
docker_env_file="./.env"

osType="unknown"
if [ "$(uname)" == "Darwin" ]; then
    osType="osx"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    osType="linux"
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    osType="windows"
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    osType="windows"
fi

# networking
if [[ "$osType" == "windows" ]]; then
    HOST_IPS=(127.0.0.1)
    XDEBUG_HOST=127.0.0.1
else
    HOST_IPS=($(ifconfig | grep "inet" | grep -v Bcast:0.0.0.0 | grep broadcast | sed -En 's/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p' | grep -v '127.'))
    XDEBUG_HOST=${HOST_IPS[0]}
fi

# Containers
declare -A CONTAINER
# must be enabled
CONTAINER[debian/debian-jessie]=enabled
CONTAINER[nginx/proxy]=enabled
# may be enabled
CONTAINER[php/php55]=enabled
CONTAINER[php/php56]=enabled
CONTAINER[php/php70]=enabled
CONTAINER[php/php71]=disabled
CONTAINER[node/node4]=enabled
CONTAINER[node/node5]=disabled
CONTAINER[node/node6]=enabled
CONTAINER[node/node10]=enabled
CONTAINER[mysql/mysql55]=enabled
CONTAINER[mysql/mysql56]=enabled
CONTAINER[elasticsearch/elastic1]=disabled
CONTAINER[elasticsearch/elastic5]=disabled
CONTAINER[redis/redis3]=enabled
CONTAINER[mongo/mongo3]=enabled

# shared volumes
VOLUME_ROOT="${HOME}/www/"
VOLUME_SSH_LOCAL_PATH="${HOME}/.ssh/"
VOLUME_SSH_LOCAL_PATH="${VOLUME_SSH_LOCAL_PATH}"
VOLUME_SSH_TARGET="/root/.ssh/"
VOLUME_BASH_HISTORY_LOCAL_PATH="${VOLUME_ROOT}docker/.bash_history"
VOLUME_BASH_HISTORY_TARGET="/root/.bash_history"

# project volumes
VOLUME_PROJECTS_LOCAL_PATH=${VOLUME_ROOT}'projects/'
VOLUME_PROJECTS_TARGET='/var/www/projects/'
VOLUME_DOMAINS_LOCAL_PATH=${VOLUME_ROOT}'domains/'
VOLUME_DOMAINS_TARGET='/var/www/domains/'
VOLUME_TOOLS_LOCAL_PATH=${VOLUME_ROOT}'bin/'
VOLUME_TOOLS_TARGET='/var/www/bin/'
VOLUME_DATABASES_LOCAL_PATH=${VOLUME_ROOT}'database/'
