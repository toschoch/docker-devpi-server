[![Docker Stars](https://img.shields.io/docker/stars/shocki/devpi-server.svg?style=flat-square)](https://hub.docker.com/r/shocki/devpi-server/)
[![Docker Pulls](https://img.shields.io/docker/pulls/shocki/devpi-server.svg?style=flat-square)](https://hub.docker.com/r/shocki/devpi-server/)

# Devpi Server Alpine Docker image

A Docker image based on [Alpine](https://hub.docker.com/_/alpine/) and as a fork of [Apihackers DevPi](https://hub.docker.com/r/apihackers/devpi/) that runs
a [devpi](http://doc.devpi.net) server (*a PyPi Cache*) with a frontend (devpi-web, devpi-theme-16).

## Usage

The user root with empty password is added after starting the server. Please add a user and change the root password right away.

```bash
docker run -d -p 3141:3141 --name devpi-server shocki/devpi-server
```

To mount your own local devpi cache directory:

```bash
docker run -d -v /path/to/devpi/home:/devpi shocki/devpi-server
```
### pip

Use a configuration similar to this in your `~/.pip/pip.conf`:

```ini
[global]
index-url = http://localhost:3141/root/pypi/+simple/
```

### setuptools

Use a configuration similar to this in your `~/.pydistutils.cfg`:

```ini
[easy_install]
index_url = http://localhost:3141/root/pypi/+simple/
```
