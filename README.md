# Openfire Container Based on OpenJDK 8

- [Introduction](#introduction)
- [Getting started](#getting-started)
  - [Quickstart](#quickstart)
  - [Persistence](#persistence)
  - [Logs](#logs)
- [References](#references)
- [Credits](#credits)

# Introduction

`Dockerfile` to create a [Docker](https://www.docker.com/) container image for [Openfire](http://www.igniterealtime.org/projects/openfire/).

Openfire is a real time collaboration (RTC) server licensed under the Open Source Apache License. It uses the only widely adopted open protocol for instant messaging, XMPP (also called Jabber). Openfire is incredibly easy to setup and administer, but offers rock-solid security and performance.

This image will be updated from Openfire version 4.2.3 up to newer versions.

# Getting started

## Image Pull

```bash
docker pull credija/openfire:lts
```

## Quickstart

Start Openfire using:

```bash
docker run --name openfire-credija -d --restart=always \
  --publish 9090:9090 --publish 5222:5222 --publish 7777:7777 \
  --publish 7070:7070 --publish 7443:7443 \
  --volume /opt/your-persistent-folder:/var/lib/openfire \
  -m 2GB \
  credija/openfire:lts \
  -XX:+UnlockExperimentalVMOptions \
  -XX:+UseCGroupMemoryLimitForHeap
```

*Alternatively, you can use the sample [docker-compose.yml](docker-compose.yml) file to start the container using [Docker Compose](https://docs.docker.com/compose/)*

Point your browser to http://localhost:9090 and follow the setup procedure to complete the installation.

## Persistence

For the Openfire to preserve its state across container shutdown and startup you should mount a volume at `/var/lib/openfire`.

> *The [Quickstart](#quickstart) command already mounts a volume for persistence.*

SELinux users should update the security context of the host mountpoint so that it plays nicely with Docker:

```bash
mkdir -p /srv/docker/openfire
chcon -Rt svirt_sandbox_file_t /srv/docker/openfire
```

## Java VM options

You may append options to the startup command to configure the JVM:

```bash
docker run --name openfire-credija -d --restart=always \
  --publish 9090:9090 --publish 5222:5222 --publish 7777:7777 --publish 7070:7070 --publish 7443:7443 \
  --volume /opt/your-persistent-folder:/var/lib/openfire \
  -m 2GB \
  credija/openfire:lts \
  -XX:+UnlockExperimentalVMOptions \
  -XX:+UseCGroupMemoryLimitForHeap
```

## Logs

To access the Openfire logs, located at `/var/log/openfire`, you can use `docker exec`. For example, if you want to tail the logs:

```bash
docker exec -it openfire tail -f /var/log/openfire/info.log
```

# Maintenance

## Upgrading

To upgrade to newer releases:

  1. Download the updated Docker image:

  ```bash
  docker pull credija/openfire:{version}
  ```

  2. Stop the currently running image:

  ```bash
  docker stop openfire-credija
  ```

  3. Remove the stopped container

  ```bash
  docker rm -v openfire-credija
  ```

  4. Start the updated image

  ```bash
  docker run -name openfire-credija -d \
    [OPTIONS] \
    credija/openfire:{version}
  ```

## Shell Access

For debugging and maintenance purposes you may want access the containers shell. If you are using Docker version `1.3.0` or higher you can access a running containers shell by starting `bash` using `docker exec`:

```bash
docker exec -it openfire-credija bash
```

# References

  * http://www.igniterealtime.org/projects/openfire/

# Credits

This container image project is based on the outdated available at: https://github.com/sameersbn/docker-openfire.
