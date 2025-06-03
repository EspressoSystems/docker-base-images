FROM ubuntu:24.04

RUN apt-get update \
    && apt-get install -y --no-install-recommends tini curl libcurl4 nodejs npm libusb-1.0.0 \
    && rm -rf /var/lib/apt/lists/* \
    && npm install -g yarn \
    && yarn global add typescript ts-node \
    && rm -rf /usr/local/share/.cache

ENTRYPOINT ["tini", "--"]
