# ~/.zshrc -*- mode: sh[zsh] -*-
rc=~/.zshrc

ZSH_THEME="simple"

# "official" plugins
plugins=(fzf git ssh-agent zoxide)

# custom plugins
plugins+=(exa2ls fzf-settings bat-settings)

# plugin development
plugins+=( testing )

source ${ZSH:-${HOME:-~}/.oh-my-zsh}/oh-my-zsh.sh

path+=( ~/.local/script )

# shellcheck disable=SC2206,SC2296
path=( ${(u)path} )

if ! [[ -L ~/.run ]]; then
    command ln -frvs ${XDG_RUNTIME_DIR:-/run/user/"$UID"} ~/.run
fi
