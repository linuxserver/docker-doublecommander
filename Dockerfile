FROM ghcr.io/linuxserver/baseimage-rdesktop-web:jammy-f5e8ed1d-ls35

# set version label
ARG BUILD_DATE
ARG VERSION
ARG DOUBLECOMMANDER_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="thelamer"

# title
ENV TITLE=DoubleCommander

RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y \
    doublecmd-gtk \
    doublecmd-plugins \
    libsmbclient \
    libssh2-1 && \
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
