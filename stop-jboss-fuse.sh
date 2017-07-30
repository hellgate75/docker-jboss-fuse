#!/bin/bash
RUNNING="$(ps -eaf|grep -v grep|grep -v 'stop-jboss-fuse'|grep -e standalone)"
if ! [[ -z "$RUNNING" ]]; then
  echo "Stopping JBoss EAP Fuse Integration Server ..."
  ps -eaf|grep -v grep|grep -e standalone|awk 'BEGIN {FS=OFS=" "}{print $2}'| xargs kill -9
else
  echo "JBoss EAP Fuse Integration Server NOT running!!"
fi
