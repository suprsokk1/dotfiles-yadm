define envVarIsSet =
#!/bin/bash
pgrep --oldest $1 |
	xargs -I PID xargs -0n1 -a /proc/PID/environ |
	grep $2
endef

makefiles = $(wildcard src/*/Makefile)

all: ${MAKECMDGOALS}

${makefiles:/Makefile=}:
	echo

.PHONY: ${MAKECMDGOALS}
