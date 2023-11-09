sudo dnf install --assumeyes jo jq pass
test -x "${HOME:~}"/.pyenv/bin/python || python3.11 -mvenv "${HOME:~}"/.pyenv
