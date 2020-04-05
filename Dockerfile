FROM python:3.7-alpine

LABEL maintainer="hchow83@gmail.com"

RUN apk add --no-cache \
    ca-certificates \
    krb5-libs \
    less \
    libgcc \
    libintl \
    libssl1.1 \
    libstdc++ \
    ncurses-terminfo-base \
    tzdata \
    userspace-rcu \
    gcc \
    zlib-dev \
    jpeg-dev \
    icu-libs \
    musl-dev \
    curl

# Install PowerShell
RUN apk -X https://dl-cdn.alpinelinux.org/alpine/edge/main add --no-cache \
    lttng-ust

RUN curl -L https://github.com/PowerShell/PowerShell/releases/download/v7.0.0/powershell-7.0.0-linux-alpine-x64.tar.gz -o /tmp/powershell.tar.gz

# Create the target folder where powershell will be placed
RUN mkdir -p /opt/microsoft/powershell/7

# Expand powershell to the target folder
RUN tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7

# Set execute permissions
RUN chmod +x /opt/microsoft/powershell/7/pwsh

# Create the symbolic link that points to pwsh
RUN ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh

RUN pwsh -c 'Install-Module PoshRSJob -Force'

RUN rm -rf /var/cache/apk/*
