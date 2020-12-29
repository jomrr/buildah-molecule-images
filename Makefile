#!/usr/bin/env bash

image_path	:= "./images"

images 		:= $(shell find $(image_path) -mindepth 1 -maxdepth 1 -type d -exec basename {} \;)

.PHONY: $(images) all clean clean-unused clean-all config parallel push test

$(images): config
	@echo -e "\e[1m$(shell date --rfc-3339 "ns") : Starting build run ... \e[0m"
	@find ./images/$@/ -mindepth 1 -maxdepth 1 -type f \
	-exec echo -e "\e[93mLaunching {} ... \e[92m" \; -exec {} \;
	@echo -e "\e[1m$(shell date --rfc-3339 "ns") : Finished build run. \e[0m"

all: $(images)

clean:
	@./images/clean

clean-unused:
	@echo -e "\e[93m$(shell date --rfc-3339 "ns") : Cleaning up unused images ... \e[0m"
	@podman image prune -af
	@echo -e "\e[93m$(shell date --rfc-3339 "ns") : Finished cleaning up unused images. \e[0m"

clean-all:
	@echo -e "\e[93m$(shell date --rfc-3339 "ns") : Cleaning up all images ... \e[0m"
	@podman rmi -af
	@echo -e "\e[93m$(shell date --rfc-3339 "ns") : Finished cleaning up all images. \e[0m"

config: clean
	@for i in ${images} ; do \
		mkdir -p ${image_path}/$$i ; \
	done
	@find ${image_path}/ -type f -exec chmod 755 {} +

parallel: config
	@echo -e "\e[1m$(shell date --rfc-3339 "ns") : Starting parallel build run ... \e[0m"
	@find ./images/ -mindepth 2 -maxdepth 2 -type f | parallel --load 80%
	@echo -e "\e[1m$(shell date --rfc-3339 "ns") : Finished parallel build run. \e[0m"

push:
	@./images/push

test:
	@echo $(images)
	@./images/test
