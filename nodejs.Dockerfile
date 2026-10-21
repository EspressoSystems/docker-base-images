FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends build-essential tini curl libcurl4 nodejs npm libusb-1.0.0 \
    && rm -rf /var/lib/apt/lists/* \
    && npm install -g yarn \
    && yarn global add typescript ts-node \
    && rm -rf /usr/local/share/.cache

# Use the system CA store (emSign ECC G3 blacklisted by ca-certificates) instead of Node's bundled roots
ENV NODE_OPTIONS=--use-openssl-ca

ENTRYPOINT ["tini", "--"]
