FROM ubuntu:18.04
LABEL maintainer="nathanwfiles@gmail.com"

RUN apt-get update \
    && apt-get install -y \
        lsb-release \
        curl \
        apt-transport-https \
        ca-certificates \
        gnupg \
        jq \
        --no-install-recommends \
    && echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" \
        | tee /etc/apt/sources.list.d/azure-cli.list \
    && curl -sSL https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl -sSL -O "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb" \
    && dpkg -i packages-microsoft-prod.deb \
    && apt-get update -qq \
    && apt-get install -y \
        azure-cli \
        azure-functions-core-tools \
        --no-install-recommends \
    && apt-get autoremove \
    && apt-get clean
