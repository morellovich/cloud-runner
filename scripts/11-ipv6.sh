#!/bin/bash
source "$1"
log() { echo "$(date +'%F %T') [IPV6] $1"; }

cat <<EOF >> /etc/sysctl.conf
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
EOF

sysctl -p

log "IPv6 disabled."
