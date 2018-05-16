# Package configuration
PROJECT = rovers
COMMANDS = rovers

DOCKER_REGISTRY = quay.io
DOCKER_ORG = srcd

GO_BUILD_ENV = CGO_ENABLED=0

# Including ci Makefile
CI_REPOSITORY ?= https://github.com/src-d/ci.git
CI_PATH ?= .ci
#TODO: use v1
CI_VERSION ?= ci-improvements

PKG_OS = linux darwin windows

MAKEFILE := $(CI_PATH)/Makefile.main
$(MAKEFILE):
	git clone --quiet --branch $(CI_VERSION) --depth 1 $(CI_REPOSITORY) $(CI_PATH);

-include $(MAKEFILE)
