include /etc/os-release
distro = ${ID}

define regex
\(\.\(aliases\|f\(dignore\|unctions\)\|profile\|ripgreprc\|sway/config\|tmux\.conf\|z\(profile\|sh\(env\|rc\)\)\)\)
endef

define tar-transform
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

tar_opts  = --directory=${HOME}
tar_opts += --exclude-vcs
tar_opts += --exclude-vcs-ignores
tar_opts += --exclude-backups
tar_opts += --exclude-caches-all
tar_opts += --transform='$(call tar-transform)'

help:
	@ echo type "'make sync'" or "'make dry run'"

dry-run:
	timeout 2 tar ${tar_opts} -cf - ${dotfiles} | tar -tvf - | tac

sync:
	tar ${tar_opts} -cf - ${dotfiles} | tar -C ${PWD}/dotfiles -xvf -
