
ESP_PORT := /dev/ttyUSB3
COMMAND_PROMPT := docker run -it --rm --device $(ESP_PORT):/dev/ttyUSB0 kalemena/esp32tools:latest

all: build

build:
	docker pull ubuntu:20.04
	docker build -t kalemena/esp32tools:latest .

flash.erase:
	$(COMMAND_PROMPT) esptool.py --chip esp32 --port /dev/ttyUSB0 erase_flash

flash.write:
	$(COMMAND_PROMPT) esptool.py --chip esp32 --port /dev/ttyUSB0 write_flash -z 0x1000 /opt/esp32-20190916-v1.11-312-g22099ab88.bin

repl:
	$(COMMAND_PROMPT) picocom /dev/ttyUSB0 -b115200

pycharm:
	bash ./pycharm.sh