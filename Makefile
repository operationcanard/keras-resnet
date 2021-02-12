CONTAINER=keras-resnet


build: export DOCKER_CLI_EXPERIMENTAL = enabled
build:
	docker buildx build -f Dockerfile -t ${CONTAINER} .

test: build
	docker run --rm ${CONTAINER}

local: build
	docker run --rm -it \
		--entrypoint=/bin/zsh \
		${CONTAINER}
