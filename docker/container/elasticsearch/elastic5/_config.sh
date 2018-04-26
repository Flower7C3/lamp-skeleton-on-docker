#!/usr/bin/env bash

VOLUME_ELASTIC5_LOCAL_PATH="${VOLUME_DATABASES_LOCAL_PATH}elasticsearch/elasticsearch5/"
echo "VOLUME_ELASTIC5_LOCAL_PATH=${VOLUME_ELASTIC5_LOCAL_PATH}" >> ${docker_env_file}
