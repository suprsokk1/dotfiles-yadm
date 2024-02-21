. "$HOME/.cargo/env"
# TODO locale i.e. LC_*=
ALTERNATE_EDITOR=vim
EDITOR=emacsclient
HOME=${HOME:-~}
LESS='-R --quit-if-one-screen'
PATH=$HOME/bin:$HOME/.local/bin${PATH:+:}$PATH
PYENV_ROOT="$HOME/.pyenv"
PYTHONSTARTUP=$HOME/.pythonrc
SYSTEMD_PAGER=
TERM=alacritty
TERMINAL=xterm
TMPDIR=$XDG_RUNTIME_DIR/tmp
VISUAL=$EDITOR
XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
XDG_RUNTIME_DIR=/run/user/${UID:-$(command id -u)}

[ -f $XDG_RUNTIME_DIR/.debug ] && DEBUG=1

# DBUS_SESSION_BUS_ADDRESS=${DBUS_SESSION_BUS_ADDRESS:-unix:path=/run/user/$(command id -u)/bus}
# SUDO_ASKPASS=$HOME/.local/bin/askpass
# PYTHONPATH=$HOME/.config/yadm/src/site-packages${PYTHONPATH:+:}${PYTHONPATH:-}
