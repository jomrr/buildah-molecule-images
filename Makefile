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
	@echo -e "\e[93mCleaning up ... \e[0m"
	@buildah unshare podman images --format "{{.ID}}" \
		--filter label=maintainer="Jonas Mauer <jam@kabelmail.net" \
		| xargs -r podman rmi -f

clean-unused:
	@echo -e "\e[93mCleaning up unused images ... \e[0m"
	@podman image prune -af

clean-all:
	@echo -e "\e[93mCleaning up all images ... \e[0m"
	@podman rmi -af

config: clean
	@for i in ${images} ; do \
		mkdir -p ${image_path}/$$i ; \
	done
	@find ${image_path}/ -type f -exec chmod 755 {} +

parallel: config
	@echo -e "\e[1m$(shell date --rfc-3339 "ns") : Starting parallel build run ... \e[0m"
	@find ./images/ -mindepth 2 -maxdepth 2 -type f | parallel "{}"
	@echo -e "\e[1m$(shell date --rfc-3339 "ns") : Finished parallel build run. \e[0m"

push:
	@echo -e "\e[93mPushing images ... \e[0m"
	@./images/push

test:
	@echo $(images)
	@./images/test
