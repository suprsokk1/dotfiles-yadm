# ~/.zshrc -*- mode: sh[zsh] -*-
ZSH_THEME="simple"

# disable oh-my-zsh update prompt
zstyle ':omz:update' mode reminder

# keep executables updated
zstyle ':completion:*' rehash true

# "official" plugins
plugins=(fzf tmux git ssh-agent zoxide)

# plugin development
plugins+=(testing)

# custom plugins
plugins+=(exa2ls fzf-settings bat-settings ripgrep docli)

# personal scripts
path+=(~/.local/script)

source ${ZSH:-${HOME:-~}/.oh-my-zsh}/oh-my-zsh.sh

# misc
hash -d zsh="$ZSH"

alias -- edit='$EDITOR'
alias -- ,='edit .'

FZF_DEFAULT_OPTS=${FZF_DEFAULT_OPTS:-"--multi --reverse --height 10"}
EDITOR="${EDITOR:-emacsclient --alternate-editor=vim}"
