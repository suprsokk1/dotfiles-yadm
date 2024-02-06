# ~/.zshrc -*- mode: sh -*-
# shellcheck disable=SC1091,SC2034
rc=~/.zshrc

if false
then

    ZSH_THEME="simple"

    # "official" plugins
    plugins=(fzf git)

    # custom plugins
    plugins+=(exa2ls)

    source $ZSH/oh-my-zsh.sh

else
    # :antigen
    [ -s ~/.antigen.zsh ] || curl -o ~/.antigen.zsh -L git.io/antigen-nightly
    . ~/.antigen.zsh

    if [ -d $ZSH ]; then
        antigen use oh-my-zsh
    fi

    # antigen bundle command-not-found
    antigen bundle direnv
    antigen bundle fzf
    antigen bundle git
    antigen bundle pip
    # antigen bundle pipx
    antigen bundle pyenv
    # antigen bundle poetry
    antigen bundle z
    `# REVIEW Blocks zsh-autosuggestions? antigen bundle zsh-syntax-highlighting`
    antigen bundle zsh-autosuggestions
    antigen bundle zsh-completions
    # antigen bundle zsh-hooks/zsh-hooks

    if true; then
        antigen theme simple            # FIXME Cause zsh shell to hang
    else
        antigen theme robbyrussell
    fi

    antigen apply
fi

# :fzf
FZF_DEFAULT_COMMAND+='_fzf__default_command'

# shellcheck disable=SC2089,SC2090
FZF_DEFAULT_OPTS=' --preview='\''_fzf__preview {+}'\'''
FZF_DEFAULT_OPTS+=' --layout=reverse'
FZF_DEFAULT_OPTS+=' --border=none'
FZF_DEFAULT_OPTS+=' --multi'
FZF_DEFAULT_OPTS+=' --height 10'
FZF_DEFAULT_OPTS+=' --bind ctrl-a:select-all'
FZF_DEFAULT_OPTS+=' --bind ctrl-t:toggle-all'
FZF_DEFAULT_OPTS+=' --bind ctrl-v:toggle-preview'
# FZF_DEFAULT_OPTS+=' --prompt="> "'
FZF_DEFAULT_OPTS+=' --query="'
FZF_DEFAULT_OPTS+='"'
FZF_DEFAULT_OPTS+=' --header="'
FZF_DEFAULT_OPTS+='C-a: Mark all C-t: Mark invert C-v:Toggle preview'
FZF_DEFAULT_OPTS+='"'
FZF_DEFAULT_OPTS+=' --prompt="> "'
# FZF_DEFAULT_OPTS+=' --bind ctrl-t:toggle-all'
export FZF_DEFAULT_OPTS

. ~/.aliases
. "$XDG_RUNTIME_DIR/.zsh"       # load generated config
. "${HOME:-~}/.cargo/env"


# :tmux - update tmux vars
function precmd {
    . ~/.precmd.zsh
}

# :alias - open files with extension with command
alias -s yaml='command $EDITOR'
alias -s yml='command $EDITOR'
alias -s json='command $EDITOR'
alias -s el='command $EDITOR'
alias -s iso='${HOME:-~}/bin/,'
alias -s git='command env -C ${HOME:-~}/src/ git clone --depth 1'
alias -s xz='tar -C ~/src/ --auto-compress -xf'
alias -s gz='tar -C ~/src/ --auto-compress -xf'
alias -s bz2='tar -C ~/src/ --auto-compress -xf'
alias -s tar='tar -C ~/src/ --auto-compress -xf'

# :rust replacements
command -v exa &>/dev/null && alias ls='command ~/.cargo/bin/exa'
command -v bat &>/dev/null && alias cat='command ~/.cargo/bin/bat'
command -v nomino &>/dev/null && alias rename='command ~/.cargo/bin/nomino'
command -v z &>/dev/null && alias cd='zshz 2>/dev/null' # zoxide

# :misc
alias edit='command ${EDITOR:-vim}'
alias sudo='command sudo --askpass'
alias notify-send='command notify-send --expire-time=3000'

# :ripgrep
RIPGREPRC=$HOME/.ripgreprc

# :sudo
SUDO_ASKPASS='/usr/bin/systemd-askpass'
if command -v askpass &>/dev/null; then
    SUDO_ASKPASS=$HOME/bin/askpass
fi

# :tmp
mkdir -p "$TMPPREFIX"

# :qrencode
if command -v qrencode &>/dev/null; then
    alias qr='command qrencode -tutf8'
fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
