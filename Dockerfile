FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy

# set version label
ARG BUILD_DATE
ARG VERSION
ARG DOUBLECOMMANDER_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="thelamer"

# title
ENV TITLE=DoubleCommander

ARG DEBIAN_FRONTEND="noninteractive"
COPY /piss /

RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y fonts-liberation libatk-bridge2.0-0 libatk1.0-0 libatspi2.0-0 libcups2 libgtk-3-0 libnspr4 libnss3 libu2f-udev libvulkan1 wget &&\
  echo "**** cleanup ****" && \
  apt-get clean && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*
RUN bash /install.sh
# add local files
RUN chmod 777 /root
COPY /root /
# ports and volumes
EXPOSE 3000
VOLUME /config
USER root
RUN bash /chromm