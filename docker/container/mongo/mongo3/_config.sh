#!/usr/bin/env bash

VOLUME_MONGO3_LOCAL_PATH="${VOLUME_DATABASES_LOCAL_PATH}mongo/mongo3/data/"
echo "VOLUME_MONGO3_LOCAL_PATH=${VOLUME_MONGO3_LOCAL_PATH}" >> ${docker_env_file}
