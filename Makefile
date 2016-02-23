.PHONY: build test

IMAGE=registry:5000/brimstone/weechat

build:
	@echo "Building ${IMAGE}"
	@docker build -t "${IMAGE}" .

push:
	@echo "Pushing ${IMAGE}"
	@docker push ${IMAGE}

test:
	@echo "Testing ${IMAGE} with serverspec"
	@docker run -i -t --rm \
	-v $(shell which docker):/usr/bin/docker \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v ${PWD}:/docker \
	-w /docker \
	-e DOCKER_ARGS="--entrypoint=/bin/bash" \
	-e IMAGE="${IMAGE}" \
	-e IMAGE_ARGS="-c 'sleep 1m'" \
	brimstone/serverspec \
	--fail-fast -c spec
