FROM ghcr.io/linuxserver/baseimage-kasmvnc:debianbookworm

# set version label
ARG BUILD_DATE
ARG VERSION
ARG DOUBLECOMMANDER_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="thelamer"

# title
ENV TITLE=DoubleCommander

ARG DEBIAN_FRONTEND="noninteractive"

RUN \
  echo "**** add icon ****" && \
  curl -o \
    /kclient/public/icon.png \
    https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/doublecommander-logo.png && \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y \
    arj \
    doublecmd-gtk \
    doublecmd-plugins \
    libsmbclient \
    libssh2-1 \
    libunrar5 \
    p7zip-full \
    unace \
    xz-utils \
    zpaq && \
  echo "**** cleanup ****" && \
  apt-get clean && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000
VOLUME /config
