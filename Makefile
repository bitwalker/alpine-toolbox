.PHONY: help

IMAGE_NAME ?= bitwalker/alpine-toolbox

help:
	@echo "$(IMAGE_NAME):latest"
	@perl -nle'print $& if m{^[a-zA-Z_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

test: ## Test the Docker image
	docker run --rm -it $(IMAGE_NAME):latest elixir --version

build: ## Rebuild the Docker image
	docker build --force-rm -t $(IMAGE_NAME):latest - < ./Dockerfile

run: ## Runs the image locally
	docker run --rm -it --user=root $(IMAGE_NAME):latest sh

release: build ## Rebuild and release the Docker image to Docker Hub
	docker push $(IMAGE_NAME):latest
