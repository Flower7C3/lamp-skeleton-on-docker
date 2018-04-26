#!/usr/bin/env bash

VOLUME_ELASTIC1_LOCAL_PATH="${VOLUME_DATABASES_LOCAL_PATH}elasticsearch/elasticsearch1/"
echo "VOLUME_ELASTIC1_LOCAL_PATH=${VOLUME_ELASTIC1_LOCAL_PATH}" >> ${docker_env_file}
