# ~/.zshrc -*- mode: sh[zsh] -*-

export FZF_DEFAULT_OPTS='--exact --layout=reverse --listen 0.0.0.0:6266 --border=none --multi --height 10 --bind ctrl-a:select-all --bind ctrl-t:toggle-all'
export FZF_API_KEY="$(head -c 32 /dev/urandom | base64)"

EDITOR="${EDITOR:-emacsclient --alternate-editor=vim}"

fpath+=(~/.local/zsh/plugins)
path+=(~/.local/script)            # personal scripts

autoload -Uz compinit

zstyle ':omz:update' mode reminder # disable oh-my-zsh update prompt
zstyle ':completion:*' rehash true # keep executables updated

# source ${ZSH:-${HOME:-~}/.oh-my-zsh}/oh-my-zsh.sh

hash -d zsh="$ZSH"
hash -d cfg="$HOME/Configure"

alias -- edit='$EDITOR'
alias -- ,='edit .'
alias -- ls='command exa --group-directories-first --icons --git'

export zsh_tmux_buffer_line=0

zmodload zsh/mapfile
zmodload zsh/pcre

fpath+=(~/opt/zsh-completions/src)
zstyle ':autocomplete:*' min-input 3
zstyle '*:compinit' arguments -D -i -u -C -w

ztyle                           # FIXME

storeVariable() {
    command git --git-dir ~/Configure/.settings/ config --add "${1}" "${2:=}"
}

add() {
    :<<-'DOC'
	Add package feature to system
	DOC

    # storeVariable "${1:=}" "${PWD}"
    # if [[ $1 =~ ]] && [[ ${(P)1} ]]; then
        # :
    # fi

}

TRAPEXIT() {
    for x in fpath; do
        : # print -n ${(P)x} | inst fpath
    done
}

alias() {
    pcre_compile -m '^(?<name>\S+)'
    pcre_match -- "$@"
    print ${MATCH['name']} >&2
    if [[ -s "$HOME"/.local/zsh/${name}.alias.zsh ]]; then
        :
    fi

    eval 'builtin alias $@'
}

__rename_me6() {
    [[ $TMUX ]] || return
    command tmux split -- $SHELL -c "$BUFFER"
}
bindkey '^[' __rename_me6        # Meta + RET (Enter)
zle -N __rename_me6

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
    string="${arr[$((zsh_tmux_buffer_line))]}"
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


if [[ $TMUX ]] && [[ $TMUX_PANE ]]; then

    tmux set-option status off # FIXME

elif [[ $TMUX ]]; then

    # tmux popup
    export FZF_DEFAULT_OPTS

    # curl -H '' -XPOST localhost:6266 -d 'reload(seq 100)+change-prompt(hundred> )'
    yadm ls-files |
        xargs -d \\n dirname --zero |
        sort -u --zero-terminated |
        xargs -0P4 fd -d1 -tf |
        fzf
fi

eval "$(command dircolors)"
