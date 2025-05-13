#!/bin/bash
source "$1"
log() { echo "$(date +'%F %T') [SYSCTL] $1"; }

cat <<EOF >> /etc/sysctl.conf

# Security hardening
net.ipv4.ip_forward = 0
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.all.rp_filter = 1
net.ipv4.tcp_syncookies = 1
EOF

sysctl -p

log "Kernel parameters tuned for security."
