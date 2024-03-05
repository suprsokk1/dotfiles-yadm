# ~/.zshrc -*- mode: sh[zsh] -*-
rc=~/.zshrc

ZSH_THEME="simple"

# "official" plugins
plugins=(fzf git ssh-agent zoxide)

# plugin development
plugins+=( testing )

# shellcheck disable=SC2206,SC2296
path=( ~/.local/script ${(u)path} ) # unique

# custom plugins
# plugins+=( exa2ls fzf-settings bat-settings )

fpath+=( ~/.local/zsh/completion ~/.local/zsh/plugins  )

if ! [[ -L ~/.run ]]; then
    command ln -frvs ${XDG_RUNTIME_DIR:-/run/user/"$UID"} ~/.run
fi

command install -DT  <(____INIT____ || ~/.local/script/____INIT____) $(mktemp "$XDG_RUNTIME_DIR"/.python-zsh-init-XXXXX.sh)
tmp="$_"
print -D "tmp"
if shellcheck -s bash "$tmp"; then
    . "$tmp"
fi

source ${ZSH:-${HOME:-~}/.oh-my-zsh}/oh-my-zsh.sh
