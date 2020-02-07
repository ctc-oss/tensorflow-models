DOCKER_PUSH?=false
IMAGE_NAMESPACE?=jwiii
IMAGE_TAG?=latest

ifeq (${DOCKER_PUSH},true)
ifndef IMAGE_NAMESPACE
$(error IMAGE_NAMESPACE must be set to push images (e.g. IMAGE_NAMESPACE=jwiii))
endif
endif

ifdef IMAGE_NAMESPACE
IMAGE_PREFIX=${IMAGE_NAMESPACE}/
endif

all: object_detection

object_detection:
	docker build --build-arg http_proxy --build-arg https_proxy -t $(IMAGE_PREFIX)object_detection:$(IMAGE_TAG) -f Dockerfile.object_detection .
	@if [ "$(DOCKER_PUSH)" = "true" ] ; then  docker push $(IMAGE_PREFIX)object_detection:$(IMAGE_TAG) ; fi
