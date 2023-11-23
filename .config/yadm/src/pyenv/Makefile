all: ${MAKECMDGOALS}

${HOME}/.pyenv:
	git clone --depth 1 https://github.com/pyenv/pyenv.git $@
	pushd $@
	./src/configure
	make -C src/

force: ${HOME}/.pyenv
	rm -rfv "$^"

.PHONY: ${MAKECMDGOALS}
