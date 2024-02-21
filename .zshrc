# ~/.zshrc -*- mode: sh -*-
rc=~/.zshrc

ZSH_THEME="simple"

# "official" plugins
plugins=(fzf git ssh-agent zoxide)

# custom plugins
plugins+=(exa2ls fzf-settings bat-settings)

# plugin development
plugins+=(testing)

source ${ZSH:-${HOME:-~}/.oh-my-zsh}/oh-my-zsh.sh

# . <(comma init zsh || echo)
