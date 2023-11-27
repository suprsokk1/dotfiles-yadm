define envVarIsSet =
#!/bin/bash
pgrep --oldest alacritty |
	xargs -I PID xargs -0n1 -a /proc/PID/environ |
	grep $1
endef
# $(shell yadm status --porcelain=v1)

foo: $(seq 100)

checks: mako

tmux:

mako:
	command -v $@
	pgrep --exact $@
	echo $$?

.PHONY: tmux
