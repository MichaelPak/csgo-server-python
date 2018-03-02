FROM ubuntu:16.04
MAINTAINER MichaelPak

ENV USER steam
ENV HOME /home/$USER
ENV SERVER $HOME/server

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

WORKDIR $SERVER

ENTRYPOINT ["csgo/srcds_run"]