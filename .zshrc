# ~/.zshrc -*- mode: sh -*-
rc=~/.zshrc

ZSH_THEME="simple"

# "official" plugins
plugins=(fzf git ssh-agent zoxide zsh-hooks)

# custom plugins
plugins+=(exa2ls)

# testing
plugins+=(example)

source ${ZSH:-${HOME:-~}/.oh-my-zsh}/oh-my-zsh.sh
