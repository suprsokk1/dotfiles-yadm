# ~/.zshrc -*- mode: sh[zsh] -*-
ZSH_THEME="simple"
FZF_DEFAULT_OPTS='--layout=reverse --border=none --multi --height 10 --bind ctrl-a:select-all --bind ctrl-t:toggle-all'
EDITOR="${EDITOR:-emacsclient --alternate-editor=vim}"

# "official" plugins
plugins=(fzf tmux git ssh-agent zoxide)

# plugin development
plugins+=(testing)

# custom plugins
plugins+=(exa2ls fzf-settings bat-settings ripgrep docli)

# personal scripts
path+=(~/.local/script)

# disable oh-my-zsh update prompt
zstyle ':omz:update' mode reminder

# keep executables updated
zstyle ':completion:*' rehash true

source ${ZSH:-${HOME:-~}/.oh-my-zsh}/oh-my-zsh.sh

# misc
hash -d zsh="$ZSH"
hash -d cfg="$HOME/Configure"

alias -- edit='$EDITOR'
alias -- ,='edit .'
alias -- ls='command exa --group-directories-first --icons --git'

__rename_me() {
    wl-copy <<< "$RBUFFER"
    notify-send --expire-time=3000 "Clipboard" "$RBUFFER"
    RBUFFER=
}

__rename_me2() {
    wl-copy <<< "$LBUFFER"
    notify-send --expire-time=3000 "Clipboard" "$LBUFFER"
    LBUFFER=
}

zle -N __rename_me
zle -N __rename_me2
bindkey '^k' __rename_me
bindkey '^u' __rename_me2

eval "$(command dircolors)"


if [[ $TMUX_PANE ]]; then
    :
else

    # tmux popup
    export FZF_DEFAULT_OPTS
    clear
    command grep -Po '^(?<=alias)[^=]*' "$HOME/.zshrc"
    yadm ls-files |
        xargs -d \\n dirname --zero |
        sort -u --zero-terminated |
        xargs -0P4 fd -d1 -tf |
        fzf
fi
