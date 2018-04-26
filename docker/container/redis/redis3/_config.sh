#!/usr/bin/env bash

VOLUME_REDIS3_LOCAL_PATH="${VOLUME_DATABASES_LOCAL_PATH}mysql/redis3/data/"
echo "VOLUME_REDIS3_LOCAL_PATH=${VOLUME_REDIS3_LOCAL_PATH}" >> ${docker_env_file}
