FROM ubuntu:16.04

MAINTAINER Fabrizio Torelli <fabrizio.torelli@wipro.com>

ENV JAVA_HOME=/usr/lib/jvm/java-8-oracle \
    EAP_HOME=/usr/lib/jboss-fuse \
    JBOSS_HOME=/usr/lib/jboss-fuse \
    JBOSS_USER=root \
    DEBIAN_FRONTEND=noninteractive

#Installing oracle java sdk 8 and Jboss fuse pre-requisites
RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install apt-utils \
    && apt-get -y install software-properties-common build-essential \
    && apt-get -y install wget curl htop git maven gradle vim net-tools \
    && add-apt-repository -y -u ppa:webupd8team/java \
    && echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
    && echo -e "\n" | apt-get -y install oracle-java8-installer oracle-java8-set-default \
    && apt-get -y autoremove \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* \
    && echo "export EAP_HOME=/usr/lib/jboss-fuse" >> /root/.bashrc \
    && echo "export JBOSS_HOME=/usr/lib/jboss-fuse" >> /root/.bashrc \
    && echo "export JBOSS_USER=root" >> /root/.bashrc \
    && mkdir -p $JBOSS_HOME \
    && mkdir -p /root/install \
    && ln -s /lib/lsb/init-functions /etc/init.d/functions


COPY auto.xml /root/install/auto.xml
COPY auto.xml.variables /root/install/auto.xml.variables
# COPY jboss-eap-6.4.0-installer.jar /root/install/jboss-eap-6.4.0-installer.jar
# COPY fuse-eap-installer-6.3.0.redhat-187.jar /root/install/fuse-eap-installer-6.3.0.redhat-187.jar
# COPY jboss-fuse-karaf-6.3.0.redhat-187.zip /root/install/jboss-fuse-karaf-6.3.0.redhat-187.zip

COPY docker-start-jboss-fuse.sh /docker-start-jboss-fuse.sh

COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod 777 /docker-start-jboss-fuse.sh \
    && chmod 777 /docker-entrypoint.sh

WORKDIR $JBOSS_HOME

CMD /docker-start-jboss-fuse.sh -daemon

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 8080 9990 9999 4447
