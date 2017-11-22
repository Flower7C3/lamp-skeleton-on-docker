#!/usr/bin/env bash

VOLUME_PROJECTS_LOCAL_PATH=${VOLUME_ROOT}'projects/'
VOLUME_PROJECTS_TARGET='/var/www/projects/'

if [[ "$DOCKER_SYNC_STRATEGY" == "" ]]; then
    VOLUME_PROJECTS_TYPE="bind"
    VOLUME_PROJECTS_SOURCE="${VOLUME_PROJECTS_LOCAL_PATH}"
    VOLUME_PROJECTS_OPTIONS=""
    VOLUME_PROJECTS_DEFINITION=""
else
    VOLUME_PROJECTS_TYPE="volume"
    VOLUME_PROJECTS_SOURCE="projects-sync"
    VOLUME_PROJECTS_OPTIONS="volume:
              nocopy: true"
    VOLUME_PROJECTS_DEFINITION="${VOLUME_PROJECTS_SOURCE}:
        external: true"
fi

VOLUME_DOMAINS_SOURCE=${VOLUME_ROOT}'domains/'
VOLUME_DOMAINS_TARGET='/var/www/domains/'
if [[ "$DOCKER_SYNC_STRATEGY" == "" ]]; then
    VOLUME_DOMAINS_TYPE="bind"
    VOLUME_DOMAINS_SOURCE="${VOLUME_DOMAINS_SOURCE}"
    VOLUME_DOMAINS_OPTIONS=""
    VOLUME_DOMAINS_DEFINITION=""
else
    VOLUME_DOMAINS_TYPE="volume"
    VOLUME_DOMAINS_SOURCE="domains-sync"
    VOLUME_DOMAINS_OPTIONS="volume:
              nocopy: true"
    VOLUME_DOMAINS_DEFINITION="${VOLUME_DOMAINS_SOURCE}:
        external: true"
fi

VOLUME_TOOLS_LOCAL_PATH=${VOLUME_ROOT}'bin/'
VOLUME_TOOLS_TARGET='/var/www/bin/'
VOLUME_DATABASES_LOCAL_PATH=${VOLUME_ROOT}'database/'