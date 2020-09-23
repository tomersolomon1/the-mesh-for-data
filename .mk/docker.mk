export DOCKER_USERNAME ?=
export DOCKER_PASSWORD ?=
export DOCKER_HOSTNAME ?= ghcr.io
export DOCKER_NAMESPACE ?= the-mesh-for-data
export DOCKER_TAGNAME ?= latest

DOCKER_NAME ?= m4d
DOCKER_FILE ?= Dockerfile
DOCKER_CONTEXT ?= .

IMG ?= ${DOCKER_HOSTNAME}/${DOCKER_NAMESPACE}/${DOCKER_NAME}:${DOCKER_TAGNAME}

GO_INPUT_FILE ?= main.go
GO_OUTPUT_FILE ?= manager

.PHONY: docker-all
docker-all: docker-build docker-push

.PHONY: docker-build
docker-build:
	docker build $(DOCKER_CONTEXT) -t ${IMG} -f $(DOCKER_FILE)

.PHONY: docker-build-local
docker-build-local:
	make docker-build IMG=${DOCKER_NAME}:${DOCKER_TAGNAME}

.PHONY: docker-push
docker-push:
ifdef DOCKER_PASSWORD
	@docker login \
		--username ${DOCKER_USERNAME} \
		--password ${DOCKER_PASSWORD} ${DOCKER_HOSTNAME}
endif
	docker push ${IMG}

.PHONY: docker-rmi
docker-rmi:
	docker rmi ${IMG} || true
