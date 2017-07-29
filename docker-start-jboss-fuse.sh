#!/bin/bash
DAEMON_COMMAND="-daemon"

function download_files() {
  wget -L https://s3-eu-west-1.amazonaws.com/dublinstudio-docker-images-software-repository/jboss-fuse/jboss-eap-6.4.0-installer.jar -O /root/install/jboss-eap-6.4.0-installer.jar
  wget -L https://s3-eu-west-1.amazonaws.com/dublinstudio-docker-images-software-repository/jboss-fuse/fuse-eap-installer-6.3.0.redhat-187.jar -O /root/install/fuse-eap-installer-6.3.0.redhat-187.jar
  wget -L https://s3-eu-west-1.amazonaws.com/dublinstudio-docker-images-software-repository/jboss-fuse/devstudio-integration-stack-10.3.0.GA-fuse-tooling-installer.jar -O /root/install/devstudio-integration-stack-10.3.0.GA-fuse-tooling-installer.jar
  wget -L https://s3-eu-west-1.amazonaws.com/dublinstudio-docker-images-software-repository/jboss-fuse-karaf-6.3.0.redhat-187.zip -O /root/install/jboss-fuse-karaf-6.3.0.redhat-187.zip
}

if [[ ! -e $JBOSS_HOME/bin && -e /root/install ]]; then
  cd $JBOSS_HOME
  echo "Installing JBoss installation files ..."
  download_files
  echo "Installing JBoss EAP 6.4.0 ..."
  java -jar /root/install/jboss-eap-6.4.0-installer.jar /root/install/auto.xml -variablefile /root/install/auto.xml.variables
  if [[ "0" != "$?" ]]; then
    echo "Error installing JBoss EAP 6.4.0"
    exit 1
  fi
  echo "Installing JBoss Fuse 6.3.0 ..."
  java -jar /root/install/fuse-eap-installer-6.3.0.redhat-187.jar
  if [[ "0" == "$?" ]]; then
    rm -Rf /root/install
  else
    echo "Error installing JBoss Fuse 6.3.0"
    exit 1
  fi
  echo "Installing JBoss Fuse 6.3.0 Karaf ..."
  unzip /root/install/jboss-fuse-karaf-6.3.0.redhat-187.zip -d /usr/lib
  mv /usr/lib/jboss-fuse-* /usr/lib/jboss-fuse-karaf
fi

RUNNING="$(netstat -anp|grep '8080 '|grep -v grep)"

if [[ -z "$RUNNING" ]]; then
  nohup $PWD/bin/standalone.sh > /var/log/jboss-fuse-bootstrap.log &
fi

netstat -anp

if [[ "$1" == "$DAEMON_COMMAND" ]]; then
  echo "Entering in sleep mode!!"
  tail -f /dev/null
elif [[ $# -gt 1 ]]; then
  echo "Executing command :  ${@:1:${#}}"
  exec  ${@:1:${#}}
else
  echo "Nothing to do, quitting ..."
fi
