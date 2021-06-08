#!/usr/bin/env bash

image_path	:= "./images"

images 		:= $(shell find $(image_path) -mindepth 1 -maxdepth 1 -type d -exec basename {} \;)

.PHONY: $(images) all clean clean-unused clean-all config docker parallel push test

$(images): config
	@./images/images $@ || exit 1

all: $(images)

clean:
	@./images/clean

clean-unused:
	@./images/clean "unused"

clean-all:
	@./images/clean "all"

config: clean
	@for i in ${images} ; do \
		mkdir -p ${image_path}/$$i ; \
	done
	@find ${image_path}/ -type f -exec chmod 755 {} +

docker:
	@./images/docker

parallel: config
	@./images/parallel

push:
	@./images/push

test:
	@echo "Makefile (images): $(images)"
	@./images/test
