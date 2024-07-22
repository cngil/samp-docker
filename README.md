<div align="center">

  <a href="https://www.sa-mp.mp/"> <img src="./samp-logo.webp" width="75%" alt="San Andreas Multiplayer Logo"/> </a>

  [![Docker Image Size (tag)](https://img.shields.io/docker/image-size/cngil/samp/latest)](https://hub.docker.com/r/cngil/samp)
  [![Docker Pulls](https://img.shields.io/docker/pulls/cngil/samp.svg)](https://hub.docker.com/r/cngil/samp)
  [![Docker Stars](https://img.shields.io/docker/stars/cngil/samp.svg)](https://hub.docker.com/r/cngil/samp)
  [![License](https://img.shields.io/github/license/cngil/samp-docker.svg)](/LICENSE)
  
</div>

> [!IMPORTANT]  
> This repository is a fork of [pyrax/samp-docker](https://github.com/Pyrax/samp-docker/). The original repository was no longer maintained and had issues. Therefore, I forked it, updated the base image, modified the download URLs, and added the latest SA-MP server versions.

This repository features some Dockerfiles for setting up a SA-MP server through Docker containers.

## Table of Contents

- [Prerequisites](#prerequisites)
- [How to Use](#how-to-use)
  - [Quickstart](#quickstart)
  - [Environment Variables](#environment-variables)
    - [Table](#table)
  - [Docker Compose](#docker-compose)
- [License](#license)

## Prerequisites

Make sure you have Docker installed properly before following any of the steps below. Visit the [official Docker site](https://www.docker.com/) for further instructions on the installation of Docker.

## How to Use

### Quickstart

Latest SA-MP version:
```bash
docker run -d -p 7777:7777/udp -e SAMP_RCON_PASSWORD=secret --name my_samp_server cngil/samp
```

Specific version:
```bash
docker run -d -p 7777:7777/udp -e SAMP_RCON_PASSWORD=secret --name my_samp_server cngil/samp:0.3.7r2-2
```

### Environment Variables

As seen in the example above, you can use environment variables to change the server.cfg file. In fact, you have to set at least the `SAMP_RCON_PASSWORD` variable in order to start the server - otherwise, the RCON password will be `changeme` and the server will shutdown right after start.

For this purpose, the entrypoint looks for any environment variable beginning with `SAMP_` and replaces the corresponding value in the server.cfg or appends a new line with the key-value-pair to the `server.cfg` if it is not present yet.

Examples:
```bash
docker run -d -p 7777:7777/udp -e SAMP_RCON_PASSWORD=secret -e SAMP_HOSTNAME="SA-MP Docker Server" --name my_samp_server cngil/samp
# "rcon_password" exists in the server.cfg, so the value is changed from "changeme" (default) to "secret"
# "hostname" also exists in the server.cfg, so it will be changed from the default value to "SA-MP Docker Server"
```

```bash
docker run -d -p 7777:7777/udp -e SAMP_RCON_PASSWORD=secret -e SAMP_PLUGINS="crashdetect" --name my_samp_server cngil/samp
# "rcon_password" exists in the server.cfg, so the value is changed from "changeme" (default) to "secret"
# "plugins" does not exist in the server.cfg, therefore a line containing "plugins crashdetect" is being appended to the server.cfg
```

### Table

Here's a table of commonly used environment variables:

| Variable            | Description                              | Default Value                  |
|---------------------|------------------------------------------|--------------------------------|
| SAMP_RCON_PASSWORD  | Sets the RCON password                   | changeme                       |
| SAMP_HOSTNAME       | Sets the server hostname                 | SA-MP 0.3 Server               |
| SAMP_MAXPLAYERS     | Sets the maximum number of players       | 50                             |
| SAMP_PORT           | Sets the server port                     | 7777                           |
| SAMP_GAMEMODE0      | Sets the first gamemode                  | grandlarc 1                    |
| SAMP_FILTERSCRIPTS  | Sets the filterscripts to be loaded      | base gl_actions gl_property gl_realtime |
| SAMP_ANNOUNCE       | Enables/disables server announcement     | 0                              |
| SAMP_QUERY          | Enables/disables querying                | 1                              |
| SAMP_WEBURL         | Sets the website URL                     | www.sa-mp.com                  |
| SAMP_MAXNPC         | Sets the maximum number of NPCs          | 0                              |
| SAMP_ONFOOT_RATE    | Sets the on-foot data rate               | 40                             |
| SAMP_INCAR_RATE     | Sets the in-car data rate                | 40                             |
| SAMP_WEAPON_RATE    | Sets the weapon data rate                | 40                             |
| SAMP_STREAM_DISTANCE| Sets the stream distance                 | 300.0                          |
| SAMP_STREAM_RATE    | Sets the stream rate                     | 1000                           |
| SAMP_LANMODE        | Enables/disables LAN mode                | 0                              |


Note: You can use any server.cfg option as an environment variable by prefixing it with `SAMP_` and using uppercase letters.

### Docker Compose

Create a `docker-compose.yml` file:

```yml
services:
  samp-server:
    image: cngil/samp:latest
    container_name: my_samp_server
    ports:
      - "7777:7777/udp"
    environment:
      - SAMP_RCON_PASSWORD=mysecretpassword
    restart: unless-stopped
```

Run with:
```sh
docker-compose up -d
```

You can customize the environment variables in the `docker-compose.yml` file according to your server requirements. Take a look at [Environment Variables Table](#table) for environment variables you can use.

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/cngil/samp-docker/blob/main/LICENSE) file for details.
