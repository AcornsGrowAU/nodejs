FROM registry.fedoraproject.org/fedora-minimal:39

SHELL ["/bin/bash", "-l", "-c"]

ARG NODE_VERSION=16

ENV npm_config_loglevel warn
ENV npm_config_unsafe_perm true

RUN microdnf --nodocs -y upgrade && \
    microdnf --nodocs -y install https://rpm.nodesource.com/pub_${NODE_VERSION}.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm && \
    microdnf --nodocs -y install \
    autoconf \
    automake \
    bash \
    ca-certificates \
    curl \
    bc \
    gcc-c++ \
    git \
    jq \
    libglvnd-glx \
    file \
    make \
    nodejs \
    postgresql \
    which && \
    microdnf --nodocs install -y tzdata && \
    microdnf clean all && \
    rm -rf /var/cache/*
