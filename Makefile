
# Update to match your ttyUSBx
ESP_PORT := /dev/ttyUSB2

# Do not update
DOCKER_CMD := docker run -it --rm --device $(ESP_PORT):/dev/ttyUSB0 -v $(CURDIR):/project
DOCKER_IMAGE := kalemena/esp32tools:latest
COMMAND_PROMPT := $(DOCKER_CMD) $(DOCKER_IMAGE)

IMAGE_FROM := ubuntu:22.04

all: build

build:
	docker pull ${IMAGE_FROM}
	docker build -t kalemena/esp32tools:latest .

flash.erase:
	$(COMMAND_PROMPT) esptool.py --chip esp32 --port /dev/ttyUSB0 erase_flash

flash.write:
	$(COMMAND_PROMPT) esptool.py --chip esp32 --port /dev/ttyUSB0 write_flash -z 0x1000 /opt/esp32-idf3-20210202-v1.14.bin

ampy.ls:
	$(COMMAND_PROMPT) ampy --port /dev/ttyUSB0 --baud 115200 ls
ampy.cmd:
	$(COMMAND_PROMPT) /bin/bash
# ampy --port /dev/ttyUSB0 --baud 115200 get boot.py /project/boot.py

repl:
	$(COMMAND_PROMPT) picocom /dev/ttyUSB0 -b115200

pycharm:
	bash ./pycharm.sh
