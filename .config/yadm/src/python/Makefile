REQUIRES := $(wildcard requires/*/Makefile)

ifndef VERSIONS
VERSIONS = 3.12.0
endif

all: ${VERSIONS}

3.%: pyenv
	yes | $^ install $@

pyenv: $(call $@)

%/Makefile: %/

%/:
	make -C $@

.PHONY: ${REQUIRES}
