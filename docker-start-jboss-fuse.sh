#!/bin/bash
DAEMON_COMMAND="-daemon"

function download_files() {
  wget -L https://s3-eu-west-1.amazonaws.com/dublinstudio-docker-images-software-repository/jboss-fuse/jboss-eap-6.4.0-installer.jar -O /root/install/jboss-eap-6.4.0-installer.jar
  wget -L https://s3-eu-west-1.amazonaws.com/dublinstudio-docker-images-software-repository/jboss-fuse/fuse-eap-installer-6.3.0.redhat-187.jar -O /root/install/fuse-eap-installer-6.3.0.redhat-187.jar
  wget -L https://s3-eu-west-1.amazonaws.com/dublinstudio-docker-images-software-repository/jboss-fuse/devstudio-integration-stack-10.3.0.GA-fuse-tooling-installer.jar -O /root/install/devstudio-integration-stack-10.3.0.GA-fuse-tooling-installer.jar
  wget -L https://s3-eu-west-1.amazonaws.com/dublinstudio-docker-images-software-repository/jboss-fuse/fuse-integration-eap-full-1.7.0.redhat-630013-installer.zip -O /root/install/fuse-integration-eap-full-1.7.0.redhat-630013-installer.zip
  wget -L https://s3-eu-west-1.amazonaws.com/dublinstudio-docker-images-software-repository/jboss-fuse/jboss-fuse-karaf-6.3.0.redhat-187.zip -O /root/install/jboss-fuse-karaf-6.3.0.redhat-187.zip
}

if [[ ! -e $JBOSS_HOME/bin && -e /root/install ]]; then
  cd $JBOSS_HOME
  echo "Downoading JBoss installation files ..."
  download_files
  echo "Installing JBoss EAP 6.4.0 ..."
  java -jar /root/install/jboss-eap-6.4.0-installer.jar /root/install/auto.xml -variablefile /root/install/auto.xml.variables
  if [[ "0" != "$?" ]]; then
    echo "Error installing JBoss EAP 6.4.0"
    exit 1
  fi
  echo "Installing JBoss Fuse 6.3.0 ..."
  java -jar /root/install/fuse-eap-installer-6.3.0.redhat-187.jar
  if [[ "0" != "$?" ]]; then
    echo "Error installing JBoss Fuse 6.3.0"
    exit 1
  fi
  echo "Installing JBoss Fuse 6.3.0 devstudio integration ..."
  echo -e "1\n" | java -jar /root/install/devstudio-integration-stack-10.3.0.GA-fuse-tooling-installer.jar
  if [[ "0" != "$?" ]]; then
    echo "Error installing JBoss Fuse 6.3.0 devstudio integration"
    exit 1
  fi
  echo "Installing JBoss Fuse 6.3.0 EAP JBoss/KIE integration ..."
  mkdir /root/install/fuse-integration
  unzip -q /root/install/fuse-integration-eap-full-1.7.0.redhat-630013-installer.zip -d /root/install/fuse-integration
  java -jar /root/install/fuse-integration/kie-eap-installer-6.5.0.Final-redhat-2.jar $EAP_HOME
  if [[ "0" != "$?" ]]; then
    echo "Error installing JBoss Fuse 6.3.0 KIE EAP integration"
    exit 1
  fi
  java -jar /root/install/fuse-integration/fuse-integration-eap-installer-1.7.0.redhat-630013.jar $EAP_HOME
  if [[ "0" != "$?" ]]; then
    echo "Error installing JBoss Fuse 6.3.0 JBoss EAP integration"
    exit 1
  fi
  echo "Configuring JBoss EAP Fuse Integration Standalone server ..."
  echo "JAVA_OPTS=\"\$JAVA_OPTS -Djboss.bind.address=0.0.0.0 -Djboss.bind.address.management=0.0.0.0 -Djboss.bind.address=0.0.0.0 -Djboss.bind.address.unsecure=0.0.0.0\"" >> bin/standalone.conf
  echo "Installing JBoss Fuse 6.3.0 Karaf for developers ..."
  unzip -q /root/install/jboss-fuse-karaf-6.3.0.redhat-187.zip -d /usr/lib
  # if [[ "0" == "$?" ]]; then
  rm -Rf /root/install\
  # else
  #   echo "Error installing JBoss Fuse 6.3.0 Karaf"
  #   exit 1
  # fi
  mv /usr/lib/jboss-fuse-* $FUSE_HOME
  sed -i s/\#admin=admin/admin=P4\$\$w0rd123/g $FUSE_HOME/etc/users.properties
  echo "Restarting JBoss EAP Fuse Integration Standalone Server ..."
  restart-jboss-fuse
  echo "Starting JBoss Fuse 6.3.0 Karaf ..."
  start-karaf-fuse
fi

RUNNING_FUSE="$(ps -eaf|grep -v grep|grep -e karaf)"
if [[ -z "$RUNNING_FUSE" ]]; then
  start-karaf-fuse
fi

RUNNING="$(ps -eaf|grep -v grep|grep -e standalone)"

if [[ -z "$RUNNING" ]]; then
  start-jboss-fuse
  cat $JBOSS_HOME/standalone/log/server.log
fi

head-jboss-fuse

if [[ "$1" == "$DAEMON_COMMAND" ]]; then
  echo "Entering in sleep mode!!"
  tail -f /dev/null
elif [[ $# -gt 1 ]]; then
  echo "Executing command :  ${@:1:${#}}"
  exec  ${@:1:${#}}
else
  echo "Nothing to do, quitting ..."
fi
