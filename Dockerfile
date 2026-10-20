FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive

# Distrust emSign ECC Root CA - G3 (CA compromise, see certifi/python-certifi#439)
RUN apt-get update \
    &&  apt-get upgrade -y \
    &&  apt-get install -y curl libcurl4 wait-for-it tini \
    &&  sed -i 's|^mozilla/emSign_ECC_Root_CA_-_G3\.crt$|!&|' /etc/ca-certificates.conf \
    &&  grep -qx '!mozilla/emSign_ECC_Root_CA_-_G3.crt' /etc/ca-certificates.conf \
    &&  update-ca-certificates \
    &&  rm -rf /var/lib/apt/lists/*
ENTRYPOINT ["tini", "--"]

# Download an SRS file to avoid download at runtime
ENV AZTEC_SRS_PATH=/kzg10-aztec20-srs-1048584.bin
RUN curl -LO https://github.com/EspressoSystems/ark-srs/releases/download/v0.2.0/$AZTEC_SRS_PATH
