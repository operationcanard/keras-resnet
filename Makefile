CONTAINER=keras-resnet

root := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
mkfile_docker_dir := /$(patsubst /%,%,$(subst $(HOME),$(USER),$(root)))

build: export DOCKER_CLI_EXPERIMENTAL = enabled
build:
	docker buildx build -f Dockerfile -t ${CONTAINER} .

test: build
	docker run --rm ${CONTAINER}

local: build
	docker run --rm -it \
		--entrypoint=/bin/zsh \
		--workdir="${mkfile_docker_dir}" \
		-v ${HOME}:/${USER} \
		-v $(abspath ${root}..):$(abspath $(mkfile_docker_dir)..) \
		${CONTAINER}
