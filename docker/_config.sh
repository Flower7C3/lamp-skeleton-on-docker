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
else
    HOST_IPS=(127.0.0.1 $(ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'))
fi

DNS_IP='8.8.8.8'

# Containers
declare -A CONTAINER
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

# database
MYSQL55_ROOT_PASSWORD=rootpasswd
MYSQL56_ROOT_PASSWORD=rootpasswd

# shared volumes
VOLUME_SSH='~/.ssh/'
VOLUME_ROOT='~/www/'
VOLUME_WWW_INDEX=${VOLUME_ROOT}'domains/default/'
VOLUME_PROJECTS=${VOLUME_ROOT}'projects/'
VOLUME_DOMAINS=${VOLUME_ROOT}'domains/'
VOLUME_TOOLS=${VOLUME_ROOT}'bin/'


### DO NOT EDIT BELOW THIS LINE ###
# IP addresses
PROXY_DOCKER_NETWORK_IP=192.168.33.1
PHP55_DOCKER_NETWORK_IP=192.168.33.55
PHP56_DOCKER_NETWORK_IP=192.168.33.56
PHP70_DOCKER_NETWORK_IP=192.168.33.70
PHP71_DOCKER_NETWORK_IP=192.168.33.71
NODE4_DOCKER_NETWORK_IP=192.168.33.104
NODE5_DOCKER_NETWORK_IP=192.168.33.105
NODE6_DOCKER_NETWORK_IP=192.168.33.106
YARN_DOCKER_NETWORK_IP=192.168.33.111
MYSQL55_DOCKER_NETWORK_IP=192.168.33.155
MYSQL56_DOCKER_NETWORK_IP=192.168.33.156
ELASTICSEARCH1_DOCKER_NETWORK_IP=192.168.33.161

# ports
PROXY_HTTP0_BRIDGED_PORT=80
PROXY_HTTPS_BRIDGED_PORT=443
MYSQL_BRIDGED_PORT=3306
MYSQL55_BRIDGED_PORT=3355
MYSQL56_BRIDGED_PORT=3356
ELASTICSEARCH1_BRIDGED_PORT=9201
NODE4_BRIDGED_PORT=9004
NODE5_BRIDGED_PORT=9005
NODE6_BRIDGED_PORT=9006
YARN_BRIDGED_PORT=9011

# hosts
PROXY_DEFAULT_HOST=php70.127.0.0.1.xip.io
PHP55_VIRTUAL_HOST=('php55.127.0.0.1.xip.io')
PHP56_VIRTUAL_HOST=('php56.127.0.0.1.xip.io')
PHP70_VIRTUAL_HOST=('php70.127.0.0.1.xip.io')
#PHP71_VIRTUAL_HOST=('php71.127.0.0.1.xip.io')
for ip in "${HOST_IPS[@]}"
do
	PHP55_VIRTUAL_HOST+=('*.php55.'$ip'.xip.io')
	PHP56_VIRTUAL_HOST+=('*.php56.'$ip'.xip.io')
	PHP70_VIRTUAL_HOST+=('*.php70.'$ip'.xip.io')
	PHP71_VIRTUAL_HOST+=('*.php71.'$ip'.xip.io')
done
PHP55_VIRTUAL_HOSTS=$(IFS=, eval 'echo "${PHP55_VIRTUAL_HOST[*]}"')
PHP56_VIRTUAL_HOSTS=$(IFS=, eval 'echo "${PHP56_VIRTUAL_HOST[*]}"')
PHP70_VIRTUAL_HOSTS=$(IFS=, eval 'echo "${PHP70_VIRTUAL_HOST[*]}"')
PHP71_VIRTUAL_HOSTS=$(IFS=, eval 'echo "${PHP71_VIRTUAL_HOST[*]}"')

