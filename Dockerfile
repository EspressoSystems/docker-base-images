FROM ubuntu:24.04

RUN apt-get update \
    &&  apt-get install -y curl libcurl4 wait-for-it tini \
    &&  rm -rf /var/lib/apt/lists/*

# Download an SRS file to avoid download at runtime
ENV AZTEC_SRS_PATH=/kzg10-aztec20-srs-1048584.bin
RUN curl -LO https://github.com/EspressoSystems/ark-srs/releases/download/v0.2.0/$AZTEC_SRS_PATH
