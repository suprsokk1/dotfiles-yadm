# -*- mode: sh -*-

:<<DOC
    Sourced by precmd()
DOC

test -s ~/.aliases && . ~/.aliases
test -s ~/.profile && . ~/.profile
# run notify-send --expire-time 500 "." "$0"

if [ -z "$TMUX_PANE" ]; then
    return
fi
