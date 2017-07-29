#!/bin/bash

if [[ ! -z "$(echo $3|grep "\-daemon")" || -z "$1" ]]; then
  echo "Running docker JBoss Fuse ..."
  chmod 777 /docker-start-jboss-fuse.sh
  /docker-start-jboss-fuse.sh -daemon
else
  echo "Executing command : $@"
  exec "$@"
fi
