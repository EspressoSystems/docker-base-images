FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive

# Distrust emSign ECC Root CA - G3 (CA compromise, see certifi/python-certifi#439)
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends build-essential tini curl libcurl4 nodejs npm libusb-1.0.0 \
    && sed -i 's|^mozilla/emSign_ECC_Root_CA_-_G3\.crt$|!&|' /etc/ca-certificates.conf \
    && grep -qx '!mozilla/emSign_ECC_Root_CA_-_G3.crt' /etc/ca-certificates.conf \
    && update-ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && npm install -g yarn \
    && yarn global add typescript ts-node \
    && rm -rf /usr/local/share/.cache

# Use the system CA store (with the emSign G3 distrust) instead of Node's bundled roots
ENV NODE_OPTIONS=--use-openssl-ca

ENTRYPOINT ["tini", "--"]
