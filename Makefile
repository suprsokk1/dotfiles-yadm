include /etc/os-release
distro = ${ID}

define tar-transform
s/^\.\(z?profile|zshrc\)/\0##default/;s|^\.doom\.d|.config/doom|
endef

define tar-transform
s|.doom.d|.config/doom|;s,^\.(z.*|profile),\0##default,
endef

files  = .profile
files += .aliases .functions
files += .zshrc .zshenv .zprofile
files += .tmux.conf .config/tmux/tmux.conf
files += .sway/config
files += .fdignore
files += .ripgreprc .regexp.lst
files += .doom.d
files += bin/,

tar_opts  = --directory=${HOME}
tar_opts += --exclude-vcs
tar_opts += --exclude-vcs-ignores
tar_opts += --exclude-backups
tar_opts += --exclude-caches-all
tar_opts += --transform='$(call tar-transform)'

help:
	@ echo type "make sync or make dry run"

dry-run:
	timeout 2 tar ${tar_opts} -cf - ${files} | tar -tvf -


sync:
	tar ${tar_opts} -cf - ${files} | \
		tar -C ${PWD}/dotfiles -xvf -
