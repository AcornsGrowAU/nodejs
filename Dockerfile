FROM registry.fedoraproject.org/fedora-minimal:36

SHELL ["/bin/bash", "-l", "-c"]

ARG NODE_VERSION=16

ENV npm_config_loglevel warn
ENV npm_config_unsafe_perm true

RUN microdnf --nodocs -y upgrade && \
    microdnf --nodocs -y install fedora-repos-modular && \
    microdnf module enable -y nodejs:${NODE_VERSION} && \
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
    microdnf --nodocs reinstall -y tzdata && \
    microdnf clean all && \
    rm -rf /var/cache/*
