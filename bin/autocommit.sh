#!/usr/bin/env bash
GIT_WORK_TREE=$(git rev-parse --show-toplevel)
export GIT_WORK_TREE
branch=${branch:-}

if [[ $(readlink $PPID) =~ fswatch ]]; then
    fswatch -o "$GIT_WORK_TREE" --event Created --event \
        Updated --event  Removed --event Renamed --event \
        OwnerModified --event AttributeModified --event MovedFrom \
        --event MovedTo --exclude ".git" |
        xargs -n1 "$(realpath "$0")"
else
    git pull --autostash origin "${branch}"
    git add .
    git commit --all -m 'fswatch'
    git push origin "${branch}"
fi
