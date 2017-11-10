#!/usr/bin/env bash

MYSQL55_ROOT_PASSWORD=rootpasswd
MYSQL55_DOCKER_NETWORK_IP=192.168.33.155
MYSQL55_BRIDGED_PORT=3355
MYSQL_BRIDGED_PORT=3306

VOLUME_MYSQL55_LOCAL_PATH="${VOLUME_DATABASES_LOCAL_PATH}mysql/mysql55/data/"
VOLUME_MYSQL55_TARGET="/var/lib/mysql"
if [[ "$DOCKER_SYNC_STRATEGY" == "" ]]; then
    VOLUME_MYSQL55_TYPE="bind"
    VOLUME_MYSQL55_SOURCE="${VOLUME_MYSQL55_LOCAL_PATH}"
    VOLUME_MYSQL55_OPTIONS=""
    VOLUME_MYSQL55_DEFINITION=""
else
    VOLUME_MYSQL55_TYPE="volume"
    VOLUME_MYSQL55_SOURCE="mysql55-sync"
    VOLUME_MYSQL55_OPTIONS="volume:
              nocopy: true"
    VOLUME_MYSQL55_DEFINITION="${VOLUME_MYSQL55_SOURCE}:
        external: true"
fi
