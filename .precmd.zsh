# -*- mode: sh -*-
test -s ~/.aliases && . ~/.aliases
test -s ~/.profile && . ~/.profile

# run notify-send --expire-time 500 "." "$0"

if [ -z "$TMUX_PANE" ]; then
    return
fi

# tmux set -g '@tmp' "$LBUFFER"
tmux set -g '@eval' ""
tmux set -g '@BUFFER' "$BUFFER"
tmux set -g '@LBUFFER' "$LBUFFER"
tmux set -g '@RBUFFER' "$RBUFFER"
tmux set -g '@zsh-plugins' "$plugins"
