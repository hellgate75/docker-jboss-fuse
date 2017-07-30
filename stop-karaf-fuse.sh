#!/bin/bash
RUNNING="$(ps -eaf|grep -v grep|grep -v 'stop-karaf-fuse'|grep karaf)"
if ! [[ -z "$RUNNING" ]]; then
  echo "Stopping JBoss Fuse Karaf Server ..."
  $FUSE_HOME/bin/stop
else
  echo "JBoss Fuse Karaf Server NOT running!!"
fi
