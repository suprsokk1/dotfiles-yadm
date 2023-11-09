HOME ?= $(shell getent passwd ${EUID} | cut -d: -f6)

${HOME}/.local/share/src/yadm: ${HOME}/.local/share/src
	git clone --depth 1 https://github.com/TheLocehiliosan/yadm.git
	ln -sfrv $*/yadm/yadm ${HOME}/bin/yadm

${HOME}/.local/share/src:
	mkdir -pv "$@"
