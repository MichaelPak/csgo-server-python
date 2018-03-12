FROM ubuntu:16.04
MAINTAINER MichaelPak

ENV USER steam
ENV HOME /home/$USER
ENV SERVER $HOME/server
ENV SOURCE $HOME/source

RUN apt-get -y update \
    && apt-get -y upgrade \
    && apt-get -y install lib32gcc1 wget net-tools lib32stdc++6 zlib1g libffi6 \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && useradd -m $USER

USER $USER
RUN mkdir $SERVER && cd $SERVER \
    && wget http://media.steampowered.com/client/steamcmd_linux.tar.gz \
    && tar -xvzf steamcmd_linux.tar.gz && rm steamcmd_linux.tar.gz \
    && ./steamcmd.sh +login anonymous +force_install_dir ./csgo +app_update 740 validate +quit

COPY Source.Python $SOURCE

RUN cp -r $SOURCE/addons/* $SERVER/csgo/csgo/addons/ \
    && cp -r $SOURCE/cfg/* $SERVER/csgo/csgo/cfg/ \
    && cp -r $SOURCE/logs/* $SERVER/csgo/csgo/logs/ \
    && cp -r $SOURCE/resource/* $SERVER/csgo/csgo/resource/ \
    && cp -r $SOURCE/sound/* $SERVER/csgo/csgo/sound/ \

WORKDIR $SERVER

ENTRYPOINT ["csgo/srcds_run"]