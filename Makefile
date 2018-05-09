# Package configuration
PROJECT = rovers
COMMANDS = rovers

DOCKER_REGISTRY = quay.io
DOCKER_ORG = srcd

# Including ci Makefile
CI_REPOSITORY ?= https://github.com/smola/ci.git
CI_PATH ?= .ci
CI_VERSION ?= ci-improvements

.SUFFIXES:

MAKEFILE := $(CI_PATH)/Makefile.main
$(MAKEFILE):
	git clone --quiet --branch $(CI_VERSION) --depth 1 $(CI_REPOSITORY) $(CI_PATH);

-include $(MAKEFILE)
