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
    DOCKER_SYNC_STRATEGY="unison"
else
    if [[ "$osType" == "osx" ]]; then
        DOCKER_SYNC_STRATEGY="native_osx"
    elif [[ "$osType" == "linux" ]]; then
        DOCKER_SYNC_STRATEGY="native_linux"
    else
        DOCKER_SYNC_STRATEGY="unison"
    fi
    HOST_IPS=($(ifconfig | grep "inet" | grep -v Bcast:0.0.0.0 | sed -En 's/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'))
    XDEBUG_HOST=${HOST_IPS[1]}
fi

DNS_IP='8.8.8.8'

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
CONTAINER[yarn/yarn]=disabled
CONTAINER[mysql/mysql55]=enabled
CONTAINER[mysql/mysql56]=enabled
CONTAINER[elasticsearch/elastic1]=disabled
CONTAINER[elasticsearch/elastic5]=disabled
CONTAINER[redis/redis3]=enabled
CONTAINER[mongo/mongo3]=enabled

# shared volumes
VOLUME_ROOT='~/www/'
VOLUME_SSH_LOCAL_PATH='~/.ssh/'
VOLUME_SSH_SOURCE="${VOLUME_SSH_LOCAL_PATH}"
VOLUME_SSH_TARGET="/root/.ssh/"

NETWORK_NAME='webserver'
