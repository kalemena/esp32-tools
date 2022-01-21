FROM ubuntu:20.04

# Doc: https://micropython.org/download/esp32/
ARG MICROPYTHON_FIRMWARE=20220117-v1.18
# https://github.com/micropython/micropython/releases/download/v1.11/micropython-1.11.tar.gz

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Kalemena ESP32 Tools" \
      org.label-schema.description="Kalemena ESP32 Tools" \
      org.label-schema.url="private" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/kalemena/esp32-tools" \
      org.label-schema.vendor="Kalemena" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install \
# Python 3
        python3 python3-pip \
# REPL tools
        wget picocom \
        && \
    rm -rf /var/lib/apt/lists/*

# Flash Tools
RUN pip3 --no-cache-dir install esptool

# Adafruit Tools
RUN pip3 --no-cache-dir install adafruit-ampy

# MicroPython Firmware
RUN cd /opt && \
    wget http://micropython.org/resources/firmware/esp32-${MICROPYTHON_FIRMWARE}.bin

CMD [ "/bin/bash" ]