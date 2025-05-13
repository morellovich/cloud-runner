#!/bin/bash
source "$1"
log() { echo "$(date +'%F %T') [WIREGUARD] $1"; }

apt-get install -y wireguard

log "WireGuard installed."
