. "$HOME/.cargo/env"
# TODO locale i.e. LC_*=
ALTERNATE_EDITOR=vim
DBUS_SESSION_BUS_ADDRESS=${DBUS_SESSION_BUS_ADDRESS:-unix:path=/run/user/$(command id -u)/bus}
EDITOR=emacsclient
EMACS='/usr/bin/emacs'
HOME=${HOME:-~}
LESS='-R --quit-if-one-screen'
PATH=$HOME/bin:$HOME/.local/bin${PATH:+:}$PATH
PYENV_ROOT="$HOME/.pyenv"
PYTHONPATH=$HOME/.config/yadm/src/site-packages${PYTHONPATH:+:}${PYTHONPATH:-}
PYTHONSTARTUP=$HOME/.pythonrc
SUDO_ASKPASS=$HOME/.local/bin/askpass
SYSTEMD_PAGER=
TERM=alacritty
TERMINAL=xterm
TMPDIR=$XDG_RUNTIME_DIR/tmp
VISUAL=$EDITOR
XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
XDG_RUNTIME_DIR=/run/user/${UID:-$(command id -u)}

export ALTERNATE_EDITOR
export PYTHONPATH
export PYTHONSTARTUP
export TMPDIR
export PYENV_ROOT
export SYSTEMD_PAGER

[ -f $XDG_RUNTIME_DIR/debug ] && DEBUG=1
