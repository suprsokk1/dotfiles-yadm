# ~/.zshrc -*- mode: sh[zsh] -*-
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="simple"
FZF_DEFAULT_OPTS='--exact --layout=reverse --listen 0.0.0.0:6266 --border=none --multi --height 10 --bind ctrl-a:select-all --bind ctrl-t:toggle-all'
EDITOR="${EDITOR:-emacsclient --alternate-editor=vim}"

plugins=(fzf tmux git ssh-agent zoxide)                   # "official" plugins
plugins+=(testing)                                        # plugin development
plugins+=(exa2ls fzf-settings bat-settings ripgrep docli) # custom plugins

path+=(~/.local/script)            # personal scripts
zstyle ':omz:update' mode reminder # disable oh-my-zsh update prompt
zstyle ':completion:*' rehash true # keep executables updated

source ${ZSH:-${HOME:-~}/.oh-my-zsh}/oh-my-zsh.sh

hash -d zsh="$ZSH"
hash -d cfg="$HOME/Configure"

alias -- edit='$EDITOR'
alias -- ,='edit .'
alias -- ls='command exa --group-directories-first --icons --git'

export ZSH_TMUX_BUFFER_LINE=0

zmodload zsh/mapfile
zmodload zsh/pcre

__rename_me() {
    [[ $BUFFER ]] || return
    wl-copy <<< "$RBUFFER"
    notify-send --expire-time=3000 "Clipboard" "$RBUFFER"
    RBUFFER=
}
bindkey '^k' __rename_me
zle -N __rename_me

__rename_me2() {
    [[ $LBUFFER ]] || return
    wl-copy <<< "$LBUFFER"
    notify-send --expire-time=3000 "Clipboard" "$LBUFFER"
    LBUFFER=
}
bindkey '^u' __rename_me2
zle -N __rename_me2

__rename_me5() {
    pcre_compile -m '\w+$'
    command tmux capturep -p | grep -P \\S | command tac > gg
    arr=("${(@f)mapfile[gg]}")
    string="${arr[$((ZSH_TMUX_BUFFER_LINE))]}"
    pcre_match -b -- "$string"
    rm -rf gg
    LBUFFER="$MATCH"
}
zle -N __rename_me5

__rename_me3() {
    ((ZSH_TMUX_BUFFER_LINE++))
    __rename_me5
}
bindkey '^[p' __rename_me3
zle -N __rename_me3

__rename_me4() {
    ((ZSH_TMUX_BUFFER_LINE--))
    __rename_me5
}
bindkey '^[n' __rename_me4
zle -N __rename_me4

eval "$(command dircolors)"

if [[ $TMUX_PANE ]]; then
    :
else

    # tmux popup
    export FZF_API_KEY="$(head -c 32 /dev/urandom | base64)"
    export FZF_DEFAULT_OPTS

    # curl -H '' -XPOST localhost:6266 -d 'reload(seq 100)+change-prompt(hundred> )'

    yadm ls-files |
        xargs -d \\n dirname --zero |
        sort -u --zero-terminated |
        xargs -0P4 fd -d1 -tf |
        fzf

fi
