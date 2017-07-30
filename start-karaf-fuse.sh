#!/bin/bash
RUNNING="$(ps -eaf|grep -v grep|grep -e karaf)"
if [[ -z "$RUNNING" ]]; then
  echo "Starting JBoss Fuse Karaf Server ..."
  $FUSE_HOME/bin/start
else
  echo "JBoss Fuse Karaf Server already running!!"
fi
