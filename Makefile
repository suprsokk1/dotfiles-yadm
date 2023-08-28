files  = .profile
files += .zshrc .zshenv .zprofile
files += .tmux.conf .config/tmux/tmux.conf
files += .sway/config
files += .fdignore
files += .ripgreprc
files += .doom.d
files += bin/,

tar_opts  = --directory=${HOME}
tar_opts += --exclude-vcs
tar_opts += --exclude-vcs-ignores
tar_opts += --exclude-backups
tar_opts += --exclude-caches
tar_opts += --transform='s|\c.doom\.d|.config/doom|'

help:
	@ echo type "make sync or make dry run"

dry-run:
	timeout 2 tar ${tar_opts} ${files} -cvf /dev/null

sync:
	tar ${tar_opts} ${files} -cf - | \
		tar -C ${PWD}/dotfiles -xvf -
