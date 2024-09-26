ARG ROCKY_VERSION
FROM rockylinux:${ROCKY_VERSION}-minimal AS base

ARG NODE_VERSION

SHELL ["/bin/bash", "-l", "-c"]

ENV npm_config_loglevel=warn npm_config_unsafe_perm=true

# COPY can be replaced with `rpm -i https://rpm.nodesource.com/pub_${NODE_VERSION}.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm`
# once repos are fully migrated from SHA1 to SHA256
COPY <<EOF /etc/yum.repos.d/nodesource-nodejs.repo
[nodesource-nodejs]
name=Node.js Packages for Linux RPM based distros
baseurl=https://rpm.nodesource.com/pub_${NODE_VERSION}.x/nodistro/nodejs/\$basearch
priority=9
enabled=1
gpgcheck=1
gpgkey=https://rpm.nodesource.com/gpgkey/ns-operations-public.key
module_hotfixes=1
EOF

RUN microdnf --nodocs -y upgrade && \
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

FROM base AS pnpm

RUN npm install -g pnpm