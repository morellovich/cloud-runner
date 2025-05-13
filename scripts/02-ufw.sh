#!/bin/bash
source "$1"
log() { echo "$(date +'%F %T') [UFW] $1"; }

log "Setting up UFW rules..."
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow 80/tcp
ufw allow 443/tcp
ufw --force enable
log "UFW configured and enabled."
