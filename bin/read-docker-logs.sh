#!/usr/bin/env bash
docker logs --follow --details --timestamps --tail 32 $1
