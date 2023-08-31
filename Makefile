include /etc/os-release
distro = ${ID}

define regex
\(\.\(aliases\|f\(dignore\|unctions\)\|profile\|ripgreprc\|sway/config\|tmux\.conf\|z\(profile\|sh\(env\|rc\)\)\)\)
endef

define transform
s|$(call regex)|\0##default|;s|^\.doom\.d|.config/doom|
endef

dotfiles  = .profile
dotfiles += .aliases .functions
dotfiles += .zshrc .zshenv .zprofile
dotfiles += .tmux.conf .config/tmux/tmux.conf
dotfiles += .sway/config
dotfiles += .fdignore
dotfiles += .ripgreprc .regexp.lst
dotfiles += .doom.d
dotfiles += bin/,
dotfiles += bin/rx				# WORK IN PROGRESS

tar_opts  = --directory=${HOME}
tar_opts += --exclude-vcs
tar_opts += --exclude-vcs-ignores
tar_opts += --exclude-backups
tar_opts += --exclude-caches-all
tar_opts += --transform='$(call transform)'

help:
	@ echo type "'make sync'" or "'make dry run'"

archive: fifo
	tar ${tar_opts} -cf $^ ${dotfiles} &

dry-run: archive
	tar -tvf fifo | tac

sync: archive
	tar -C ${PWD}/dotfiles -xvf fifo

fifo:
	mkfifo $@

.PHONY: archive dry-run help sync
