#!/usr/bin/env bash
host={HOSTNAME%%.*}
date=$(date +%s | colrm 5 999)
cache=/dev/shm/."$date".toml
args=("$@")
last="/tmp/.${0##*/}.last"
opts=('--list' '--host')

if ! [ -f "$cache"  ]; then
    if command -v mpm &>/dev/null; then
        command mpm freeze 2>/dev/null
    fi | tee "$cache"
else
    cat "$cache"
fi
export host


envsubst <<'STATIC' | gron | sed -E '/^json./s|||;{s#^#packages.installed#}'
json.all.children[0] = "ungrouped";
json._meta.hostvars.localhost = {};
json._meta.hostvars.${host} = {};
json.ungrouped.hosts[0] = "localhost";
json.ungrouped.hosts[1] = "${host}";
STATIC

    case "${args[@]}" in
    *--host*)
        sed -E 's|^|json._meta.hostvars.'"$host"'\1|'
        ;;
    *--list*)
        sed -E 's|^|json._meta.hostvars.'"$host"'\1|'
        # sed -E '/json([[:print:]]+)/s||json._meta.hostvars.'"$host"'\1|'
        ;;
    *)
esac

trap '__exit__' EXIT

:<<GRON_EXAMPLE
json = {};
json._meta = {};
json._meta.hostvars = {};
json._meta.hostvars.localhost = {};
json._meta.hostvars.localhost.foo = "bar";
json.all = {};
json.all.children = [];
json.all.children[0] = "ungrouped";
json.ungrouped = {};
json.ungrouped.hosts = [];
json.ungrouped.hosts[0] = "localhost";
GRON_EXAMPLE
# test -f "$last" && wc -l "$last"
# set - "${@:-${opts[@]}}"
# __exit__() {
#     {
#         touch "$last"
#         echo $$ >> $_
#     } &>/dev/null
# }
