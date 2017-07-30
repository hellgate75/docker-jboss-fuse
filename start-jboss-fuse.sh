#!/bin/bash
RUNNING="$(ps -eaf|grep -v grep|grep -v 'start-jboss-fuse'|grep -e standalone)"
if [[ -z "$RUNNING" ]]; then
  echo "Starting JBoss EAP Fuse Integration Server ..."
  nohup $JBOSS_HOME/bin/standalone.sh > $JBOSS_HOME/standalone/log/server.log &
else
  echo "JBoss EAP Fuse Integration Server already running!!"
fi
