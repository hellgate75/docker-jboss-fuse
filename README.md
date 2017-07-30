# JBoss Fuse Docker container

90-days trial JBoss Fuse docker image


## Docker container for newly released JBoss Fuse ESB server

This continer install on first start-up following features:

* JBoss Fuse 6.3.0 integration on JBoss EAP 6.4.0
* JBoss Fuse 6.3.0 over Apache Karaf

Available Docker image versions :

* JBoss Fuse 6.3.0 Docker ([Dockerfile](https://github.com/hellgate75/docker-jboss-fuse/tree/master/Dockerfile))

Source Repositories :

* [docker-jboss-fuse](https://github.com/hellgate75/docker-jboss-fuse)

Source Repositories :

* [jboss-fuse docker-hub page](https://hub.docker.com/r/hellgate75/jboss-fuse/)


### Goals

This project realises a sample 90-days trial version of JBoss Fuse 6.3.0, in order to evaluate one of latest ReadHat eficient ESB server based on osgi and Apache Camel technologies. This project define a StandAlone environment for test purposes only.

*Caution* : No warranties are extended to production or business use of this container, and we are not responsible for illegal or inappropriate use of this project outcomes or any damage on business or digital crime, derived for third-parties actions.


### Our Philosophy

`Try it. Determine business value, derived from product features. Then you consider to buy a license and/or implement a production-ready docker image, accordingly to Product Provider trading or commercial rules.`

*Assumptions* : All our docker images are continuous delivery process ready, and all of them have been tested on `Kubernetes`, `MESOS`, `Portainer.IO`, `Rancher` and `Spinnaker` delivery frameworks, before we released on Docker Hub.


### About JBoss Fuse

Here a list of RehHat related pages :

* [Homepage](https://www.redhat.com/en/technologies/jboss-middleware/fuse)

* [Getting Started](https://access.redhat.com/documentation/en/red-hat-jboss-fuse/?version=6.3)


### Docker Environment

Docker container exposes following ports:

* `8009` :

JBoss EAP 6.4.0 AJP port

* `8080` :

JBoss EAP 6.4.0 HTTP port

* `8181` :

JBoss Fuse 6.3.0 HTTP port

* `8101` :

JBoss Fuse 6.3.0 JMX port

* `9990` :

JBoss EAP 6.4.0 Management HTTP port

* `9443` :

JBoss EAP 6.4.0 Management HTTPS port

* `9999` :

JBoss EAP 6.4.0 Management Native port

* `4447` :

JBoss EAP 6.4.0 Remoting port

* `8443` :

JBoss EAP 6.4.0 Management HTTPS port

* `4712` :

JBoss EAP 6.4.0 Transaction Recovery Environment port

* `4713` :

JBoss EAP 6.4.0 Transaction Status Manager port


Docker container exposes following volumes:

*No exposed valume for this docker image*



Docker container defines following environment variables:

*No defined environment variables for this docker image*


### Build Docker image

In order to build this docker image, in project root, you can use following command :

```bash
docker build --rm --force-rm --tag jboss-fuse:6.3.0 .
```

Or you can simply dowload the Docker hub built one, using following command :

```bash
docker pull hellgate75/jboss-fuse:6.3.0
```


### Execute Docker image

In order to execute this docker image, after you have built the image, you can use following command :

```bash
docker run -d --name jboss-fuse-6.3.0 -p 8009:8009 -p 8080:8080 -p 9999:9999 -p 9990:9990 -p 9443:9443 -p 4447:4447 -p 8443:8443 \
            -p 4712:4712 -p 4713:4713 -p 8181:8181 -p 8101:8101 jboss-fuse:6.3.0 .
```

In order to execute Docker Hub image, without any prior docker build, you can use following command :

```bash
docker run -d --name jboss-fuse-6.3.0 -p 8009:8009 -p 8080:8080 -p 9999:9999 -p 9990:9990 -p 9443:9443 -p 4447:4447 -p 8443:8443 \
            -p 4712:4712 -p 4713:4713 -p 8181:8181 -p 8101:8101 hellgate75/jboss-fuse:6.3.0 .
```


### Access Docker container features

In order to access docker container shell, after container ran, you can use following command :

```bash
docker exec -it jboss-fuse-6.3.0 bash
```

When you login to container you will display service health information and console access urls


In access to JBoss Fuse 6.3.0 management web console you can type on your browser following address:

```bash
http://[ container-ip or localhost ]:8181/
```

Web Console credentials in current sampler are : admin/P4$$w0rd123


In access to JBoss EAP 6.4.0 management web console you can type on your browser following address:

```bash
http://[ container-ip or localhost ]:9990/
```

Web Console credentials in current sampler are : admin/P4$$w0rd123


### Issues

Please report any issue on project Issue Tracker at :

[docker-jboss-fuse Issue Tracker](https://github.com/hellgate75/docker-jboss-fuse/issues)


### LICENSE

[LGPL v.3](https://github.com/hellgate75/docker-jboss-fuse/tree/master/LICENSE)
