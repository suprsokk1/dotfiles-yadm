# -*- mode: sh[zsh] -*-
zmodload zsh/mapfile
zmodload zsh/pcre

function _tmux_completion_helper {
    command tmux capturep -p | command grep -Poz '[^\n]+$'
    return
    command tmux capturep -p |
        command regex2json '(?P<line>^.*$)' |
        jq -rcM '.line'
}

function _tmux {
    _tmux_completion_helper | tee /dev/shm/.gg
    reply=("${(f@)mapfile[/dev/shm/.gg]}")
    # [ -n "$TMUX" ] || return 0
}

function _tmux_dnf {
    _tmux_completion_helper | tee /dev/shm/.gg
    reply=("${(f@)mapfile[/dev/shm/.gg]}")
    # [ -n "$TMUX" ] || return 0
}

autoload -U compinit; compinit
zstyle ':completion:*' file-list all
zstyle ':completion:*' use-cache on
# zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*:descriptions' format '%U%K{yellow} %F{green}-- %F{red} %BNICE!1! %b%f %d --%f%k%u'


foo() {
    echo "$@"
}

compctl -K _tmux foo
compctl -K _tmux_dnf dnf
compctl -K _tmux_dnf yum
