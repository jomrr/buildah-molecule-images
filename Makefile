#!/usr/bin/env bash

start_run=$$(date --rfc-3339 "ns")

all_images=$$(find ./images/ -mindepth 2 -maxdepth 2 -type f)

image_path="./images"

images=alpine amazonlinux archlinux centos debian fedora oraclelinux opensuse ubuntu

.PHONY: all $(images) config test-% clean

all: $(images)

$(images): config
	@echo -e "\e[1m$(start_run) : Starting build run ... \e[0m"
	@find ./images/$@/ -mindepth 1 -maxdepth 1 -type f \
	-exec echo -e "\e[93mLaunching {} ... \e[92m" \; -exec {} \;

config: clean
	@for i in $(images) ; do \
		mkdir -p $(image_path)/$$i ; \
	done
	@find $(image_path)/ -type f -exec chmod 755 {} +

test-%:
	$(eval dist := $(shell echo $@ | cut -d '-' -f2 ))
	$(eval tags := $(shell find ./images/$(dist)/ -mindepth 1 -maxdepth 1 \
		-type f -exec basename {} \;))
	@for t in $(tags) ; do \
		echo $(dist):$$t ; \
	done

clean:
	@echo -e "\e[93mCleaning up ... \e[0m"
