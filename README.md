CS:GO server in Docker with Source.Python
---
[![CircleCI](https://circleci.com/gh/MichaelPak/csgo-server-python/tree/master.svg?style=svg&circle-token=dbc738f3656012039f16a3f747df0f06847da4e2)](https://circleci.com/gh/MichaelPak/csgo-server-python/tree/master) [![](https://images.microbadger.com/badges/version/michaelpak/csgo-server-python.svg)](https://hub.docker.com/r/michaelpak/csgo-server-python/) [![](https://images.microbadger.com/badges/image/michaelpak/csgo-server-python.svg)](https://microbadger.com/images/michaelpak/csgo-server-python)

## Introduction
This docker image is based on [phusion's base image] and contains pre-installed [Source.Python].

## Run

```sh
$ export PORT=27015
$ export TOKEN=6CED5D787E233621553813F207B2B
$ docker run -it --name csgo_srv
    -p $PORT:$PORT/udp \
    michaelpak/csgo-server-python:latest \
    -console -game csgo -console -tickrate 128 -port $PORT -maxplayers_override 10 \
    +game_type 1 +game_mode 2 +map de_dust2 \
    +sv_setsteamaccount $TOKEN
```

   [phusion's base image]: <https://github.com/phusion/baseimage-docker>
   [Source.Python]: <https://github.com/Source-Python-Dev-Team/Source.Python>
   Ho!