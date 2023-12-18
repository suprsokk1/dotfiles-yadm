# -*- mode: sh[zsh] -*-
function _tmux_completion_helper {
    command tmux capturep -p |
        command grep -Poz '[^\n]+$'
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
