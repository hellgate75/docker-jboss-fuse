#!/bin/bash
RUNNING="$(ps -eaf|grep -v grep|grep -e karaf)"
if ! [[ -z "$RUNNING" ]]; then
  echo "Stopping JBoss Fuse Karaf Server ..."
  $FUSE_HOME/bin/stop
else
  echo "JBoss Fuse Karaf Server NOT running!!"
fi
