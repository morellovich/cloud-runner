#!/bin/bash
source "$1"
log() { echo "$(date +'%F %T') [RKHUNTER] $1"; }

apt-get install -y rkhunter
rkhunter --update
rkhunter --propupd

log "Rootkit Hunter installed and initialized."
