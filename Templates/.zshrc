# .zshrc -*- mode: sh -*-
# shellcheck disable=SC1091,SC2034

ZSH=$HOME/.oh-my-zsh
ZSH_THEME=simple

hash -d yadm=${HOME}/.config/yadm
hash -d run=${XDG_RUNTIME_DIR:-/run/user/${EUID:-$(id -u)}}
hash -d config=${XDG_CONFIG_HOME:-${HOME}/.config}
hash -d fonts=${HOME}/.local/share/fonts
hash -d autorun=${HOME}/.config/autorun
hash -d desktop=${HOME}/.local/share/applications
hash -d apps=${HOME}/.local/share/applications
hash -d zsh=$ZSH


plugins=(zsh-autosuggestions direnv fzf tmux)

path=($HOME/bin $HOME/.pyenv/bin /usr/bin /usr/local/bin /usr/local/sbin /usr/sbin $HOME/.cargo/bin $HOME/.local/bin $HOME/go/bin $HOME/opt/doom-emacsdir/bin). ${ZSH:-$HOME/src/ohmyzsh}/oh-my-zsh.sh
. ~/.functions
. ~/.aliases
. <(cat ~/.sh.d/*.zsh)

### END ###
