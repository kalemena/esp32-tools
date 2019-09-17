FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install python3 python3-pip;

RUN apt-get -y install wget picocom && \
    pip3 install esptool

RUN cd /opt && \
    wget http://micropython.org/resources/firmware/esp32-20190916-v1.11-312-g22099ab88.bin

CMD [ "/bin/bash" ]